// Class use for returning tokens as objects
public class Symbol {
    String token;
    String lexeme;
    int line;
    int column;

    public String getLexeme() { return this.lexeme; }

    public String getToken() { return this.token; }

    Symbol(String token, String lexeme, int line, int column) {
        this.lexeme = lexeme;
        this.token = token;
        this.line = line;
        this.column = column;
    }

    public String toString() {
        String symbol = "";
        if (lexeme.length() >= 8)
            symbol = String.format("%s\t<- [%s] (Linea: %d, Columna: %d)", lexeme, token, line, column);
        else
            symbol = String.format("%s\t\t<- [%s] (Linea: %d, Columna: %d)", lexeme, token, line, column);
        return symbol;
    }
}