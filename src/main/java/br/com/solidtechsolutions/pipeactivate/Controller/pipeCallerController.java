package br.com.solidtechsolutions.pipeactivate.Controller;

import ch.qos.logback.core.net.ObjectWriter;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
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
    public void controleFinanceiroPipeCaller(@RequestBody Object object, HttpServletRequest request) {

        System.out.println("objeto recebido -->"+ object.toString());
        System.out.println("request recebidos" + request.toString());
        String cmd;
        if(object.toString().contains("ref=refs/heads/develop")){
            cmd = "sh /pipes/controlefinanceiro-dev.sh";
        }else if(object.toString().contains("ref=refs/heads/develop")){
            cmd = "sh /pipes/controlefinanceiro-dev.sh";
        }else{
            cmd = "sh /pipes/controlefinanceiro-dev.sh";
        }

        //tratamento de erro e execução do script

        try {
            Process process = Runtime.getRuntime().exec(cmd);
        } catch (IOException ex) {
            Logger.getLogger("io exception ao executar pipe controlefinanceiro-dev.sh").log(Level.SEVERE, "io exception ao executar pipe controlefinanceiro-dev.sh", ex);
        }

    }
}
