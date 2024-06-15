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


    @PostMapping("/controlefinanceiro")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void controleFinanceiroPipeCaller(@RequestBody Object object, HttpServletRequest request) throws IOException, InterruptedException {
        System.out.println("endpoint controlefinanceiro ativado");
        System.out.println(object.toString().substring(0,50));
        String cmd = getCommandControleFinanceiroBackend(object.toString());
        executeCommand(cmd);
    }
    @PostMapping("/controlefinanceiro-front")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void controleFinanceiroFrontPipeCaller(@RequestBody Object object, HttpServletRequest request) throws IOException, InterruptedException {
        System.out.println("origen da chamada " + request);
        System.out.println("endpoint controlefinanceiro-front ativado");
        System.out.println(object.toString().substring(0,50));
        String cmd = getCommandControleFinanceiroFrontend(object.toString());
        executeCommand(cmd);
    }

    @PostMapping("/lourivalekamyla-front")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void lourivalEKamylaFrontPipeCaller(@RequestBody Object object, HttpServletRequest request) throws IOException, InterruptedException {
        System.out.println("origen da chamada " + request);
        System.out.println("endpoint lourivalekamyla-front ativado");
        System.out.println(object.toString().substring(0,50));
        String cmd = getLourivaleKamylaPage(object.toString());
        executeCommand(cmd);
    }

    @PostMapping("/landing")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void landingLowyerPipeCaller(@RequestBody Object object, HttpServletRequest request) throws IOException, InterruptedException {
        System.out.println("origen da chamada " + request.getRequestURI());
        System.out.println(object.toString().substring(0,50));
        String cmd = getLandingPage(object.toString());
        executeCommand(cmd);
    }

    @PostMapping("/apipagamentos")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void apiPagamentosCaller(@RequestBody Object object, HttpServletRequest request) throws IOException, InterruptedException {
        System.out.println("endpoint apiPagamentos ativado");
        System.out.println(object.toString().substring(0,50));
        String cmd = getCommandControleFinanceiroBackend(object.toString());
        executeCommand(cmd);
    }

    private String getCommandApiPagamentosBackend(String objectString) {
        return "sh /opt/workspace/pipeactivate/pipes/apipagamentos.sh";
    }

    private String getCommandControleFinanceiroBackend(String objectString) {
        if (objectString.startsWith("{ref=refs/heads/develop")) {
            System.out.println("branch origin --> ref=refs/heads/develop ");
            return "sh /opt/workspace/pipeactivate/pipes/controlefinanceiro-dev.sh";
        } else if (objectString.startsWith("{ref=refs/heads/prod")) {
            System.out.println("branch origin --> ref=refs/heads/prod ");
            return "sh /opt/workspace/pipeactivate/pipes/controlefinanceiro-prod.sh";
        }
        return null;
    }
    private String getLandingPage(String objectString) {
            return "sh /opt/workspace/pipeactivate/pipes/landing.sh";
    }


    private String getLourivaleKamylaPage(String objectString) {
        return "sh /opt/workspace/pipeactivate/pipes/lourivalekamyla-front.sh";
    }

    private String getCommandControleFinanceiroFrontend(String objectString) {
        if (objectString.startsWith("{ref=refs/heads/develop")) {
            System.out.println("branch origin --> ref=refs/heads/develop ");
            return "sh /opt/workspace/pipeactivate/pipes/controlefinanceiro-front-dev.sh";
        } else if (objectString.startsWith("{ref=refs/heads/prod")) {
            System.out.println("branch origin --> ref=refs/heads/prod ");
            return "sh /opt/workspace/pipeactivate/pipes/controlefinanceiro-front-prod.sh";
        }
        return null;
    }

    private void executeCommand(String cmd) throws IOException, InterruptedException {
        System.out.println("rodando sh");
        if (cmd != null) {
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
}


