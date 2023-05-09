// Class use for returning tokens as objects
public class Token {
    String _token;
    String _lexema;

    public String getLexema() {
        return this._lexema;
    }

    public String getToken() {
        return this._token;
    }

    Token(String lexema, String token) {
        this._lexema = lexema;
        this._token = token;
    }

    public String toString() {
        String symbol = String.format("Lexema: %s Token: %s",_lexema, _token); 
        return symbol;
    }
}