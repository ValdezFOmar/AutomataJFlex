import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
// import java.util.List;
// import java.util.Arrays;

// Main class for reading the file and printing the results
public class Main {
    public static void main(String[] args) {
        //List<String> identifiers = new ArrayList<String>();
        String input = "src/resources/input.txt";
        
        try {            
            // Leer el archivo y analizarlo en la clase que se ha creado con JFlex
            BufferedReader buffer = new BufferedReader(new FileReader(input));
            Lexer lexer = new Lexer(buffer);

            while (true) {
                // Obtener el token
                Token token = lexer.nextToken();

                if (!lexer.thereIsTokens())
                    break;
                System.out.println(token.toString());
            }
            
            // Print total number of tokens found
            int count = lexer.numberTokens();
            System.out.println("\n----------------------------------------");
            System.out.println(String.format("Numero total de tokens:   %d.", count));
            System.out.println("----------------------------------------\n");

        } catch (FileNotFoundException e) {
            System.out.println(String.format("File (%s) not found.", input));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
