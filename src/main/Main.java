import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;
import java_cup.runtime.ComplexSymbolFactory;

// Main class for reading the file and printing the results
// For reloading .class: F1 > Clean java language server workspace
public class Main {
    public static void main(String[] args) {
        String input_lexer = "test/inputLexer.txt";
        String input_syntax = "test/inputSyntax.txt";

        System.out.print("Escoge una opcion -> (1) Lexico (2) Sintactico: ");
        String awnser = System.console().readLine();
        try {
            int opt = Integer.parseInt(awnser);

            switch (opt) {
                case 1:
                    AnalizadorLexico(input_lexer);
                    break;
                case 2:
                    AnalizadorSintactico(input_syntax);
                    break;
                default:
                    System.out.println("Opcion invalida.");
                    break;
            }
        } catch (NumberFormatException e) {
            System.out.println("Opcion Invalida. Introduce un numero.");
        }
    }

    private static void AnalizadorLexico(String input_file_path) {
        Queue<Token> tokens = new LinkedList<Token>();

        try {
            // Read File
            BufferedReader buffer = new BufferedReader(new FileReader(input_file_path));
            Lexer lexer = new Lexer(buffer);

            // Get tokens from file
            Token token = new Token();
            while (true) {
                token = lexer.nextToken();
                if (!lexer.thereIsTokens())
                    break;
                tokens.offer(token);
            }

            // Print tokens
            System.out.println("\n-----------------------------------");
            if (!tokens.isEmpty()) {
                for (Token t : tokens) {
                    System.out.println(t);
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
            System.out.println(String.format("File \"%s\" not found.", input_file_path));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void AnalizadorSintactico(String input_file_path) {
        try {
            // Read File
            BufferedReader buffer = new BufferedReader(new FileReader(input_file_path));

            ComplexSymbolFactory sf = new ComplexSymbolFactory();
            Parser p = new Parser(new LexerCup(buffer, sf), sf);
            p.parse();

        } catch (FileNotFoundException e) {
            System.out.println(String.format("File \"%s\" not found.", input_file_path));
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
