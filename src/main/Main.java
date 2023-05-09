import java.io.BufferedReader;
import java.io.FileReader;

public class Main {
    public static void main(String[] args) {
        // Main class for reading the file and printing the results
        try {
            //List<String> identifiers = new ArrayList<String>();
            String input = "src/resources/input.txt";
            
            // Leer el archivo y analizarlo en la clase que se ha creado con JFlex
            BufferedReader buffer = new BufferedReader(new FileReader(input));
            Lexer lexer = new Lexer(buffer);

            while (true) {
                // Obtener el token
                Symbol token = lexer.yylex();

                if (!lexer.thereIsTokens())
                    break;
                System.out.println(token.toString());
            }
            
            // Print total number of lexemex found
            // System.out.printf("----------------------------------------\n");
            // System.out.printf("Numero total de palabras: %d.\n",keywords);
            // System.out.printf("----------------------------------------\n");
        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }
}
