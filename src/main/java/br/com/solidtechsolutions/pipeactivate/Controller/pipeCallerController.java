package br.com.solidtechsolutions.pipeactivate.Controller;

import ch.qos.logback.core.net.ObjectWriter;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@Slf4j
@RestController
@RequestMapping("/pipecaller")
public class pipeCallerController {


    @PostMapping("/imslandingpage")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void imsLandingpagePipeCaller(@RequestBody Object object, HttpServletRequest request) {

        System.out.println("objeto recebido -->"+ object.toString());
        System.out.println("request recebidos" + request.toString());

        String cmd = "sh /pipes/imslandingpage.sh";  //e.g test.sh -dparam1 -oout.txt
        //tratamento de erro e execução do script

        try {
            Process process = Runtime.getRuntime().exec(cmd);
        } catch (IOException ex) {
            Logger.getLogger("io exception ao executar pipe imslandingpage.sh").log(Level.SEVERE, "io exception ao executar pipe imslandingpage.sh", ex);
        }

    }
    @PostMapping("/controlefinanceiro")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void controleFinanceiroPipeCaller(@RequestBody Object object, HttpServletRequest request) throws IOException, InterruptedException {
        System.out.println("objeto recebido -->" + object.toString());
        System.out.println("request recebidos" + request.toString());
        String cmd = getCommand(object.toString());
        executeCommand(cmd);
    }
    private String getCommand(String objectString) {
        if (objectString.contains("ref=refs/heads/develop")) {
            System.out.println("entrou no if contem --> 'ref=refs/heads/develop' ");
            return "sh /opt/workspace/pipeactivate/pipes/controlefinanceiro-dev.sh";
        } else if (objectString.contains("ref=refs/heads/prod")) {
            System.out.println("entrou no if contem --> 'ref=refs/heads/prod' ");
            return "sh /opt/workspace/pipeactivate/pipes/controlefinanceiro-prod.sh";
        } else {
            return "sh /opt/workspace/pipeactivate/pipes/controlefinanceiro-dev.sh";
        }
    }

    private void executeCommand(String cmd) throws IOException, InterruptedException {
        System.out.println("rodando sh");
        Process process = Runtime.getRuntime().exec(cmd);

        // cria os objetos para ler a saída e o erro do processo
        BufferedReader stdout = new BufferedReader(new InputStreamReader(process.getInputStream()));
        BufferedReader stderr = new BufferedReader(new InputStreamReader(process.getErrorStream()));



        // lê a saída do processo e grava no arquivo de log
        String line;
        while ((line = stdout.readLine()) != null) {
            System.out.println(line);
        }

        // lê o erro do processo e grava no arquivo de log
        while ((line = stderr.readLine()) != null) {
            System.out.println(line);
        }

        // aguarda o término do processo
        process.waitFor();

        // imprime o status de saída do processo
        System.out.println("status: " + process.exitValue());
    }
}


