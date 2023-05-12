import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

// Main class for reading the file and printing the results
public class Main {
    public static void main(String[] args) {
        String input = "src/resources/input.txt";
        Queue<Token> tokens = new LinkedList<Token>();

        try {
            // Read File
            BufferedReader buffer = new BufferedReader(new FileReader(input));
            Lexer lexer = new Lexer(buffer);

            // Get tokens from file 
            while (true) {
                Token token = lexer.nextToken();
                if (!lexer.thereIsTokens())
                    break; 
                tokens.offer(token);
            }
            
            // Print tokens
            System.out.println("\n-----------------------------------");
            if (!tokens.isEmpty()) {
                for (Token token : tokens) {
                    System.out.println(token);
                }
            }
            System.out.println("-----------------------------------");

            // Print total number of tokens found
            int numLexemes = lexer.numberTokens();
            System.out.println("\n-----------------------------");
            System.out.println(String.format("Numero total de palabras: %d", numLexemes));
            System.out.println("-----------------------------\n");
            // System.out.println(lexer.getIdentifiers());

        } catch (FileNotFoundException e) {
            System.out.println(String.format("File \"%s\" not found.", input));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
