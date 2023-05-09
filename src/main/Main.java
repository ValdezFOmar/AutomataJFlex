import java.io.BufferedReader;
import java.io.FileReader;

public class Main {
    public static void main(String[] args) throws Exception {
        // Main class for reading the file and printing the results
        try {
            String archivo = "prueba.txt";

            // Leer el archivo y analizarlo en la clase que se ha creado con JFlex
            BufferedReader buffer = new BufferedReader(new FileReader(archivo));
            Lexer lexer = new Lexer(buffer);

            // while (true) {
            //     // Obtener el token y mostrar su informacion
            //     TokenPersonalizado token = lexer.yylex();
                
            //     if (!lexer.existenTokens()) break;
            //     System.out.println(token.toString());
            // }

        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }
}
