// Class use for returning tokens as objects
public class Token {
    private String token;
    private String lexeme;
    private int line;
    private int column;

    public String getLexeme() {
        return this.lexeme;
    }
    
    public String getToken() {
        return this.token;
    }
    
    public int getLine() {
        return this.line;
    }

    public int getColumn() {
        return this.column;
    }
    
    Token(String token, String lexeme, int line, int column) {
        this.lexeme = lexeme;
        this.token = token;
        this.line = line + 1;
        this.column = column + 1;
    }

    public String toString() {
        String symbol = "";
        // (Linea: %d, Columna: %d)
        if (lexeme.length() >= 8)
            symbol = String.format("%s\t<-\t[%s]", lexeme, token);
        else
            symbol = String.format("%s\t\t<-\t[%s]", lexeme, token);
        return symbol;
    }
}