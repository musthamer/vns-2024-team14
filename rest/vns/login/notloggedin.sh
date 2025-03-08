#!/usr/bin/env bash

if [ "$message" != "" ]; then
  echo "<p>$message</p>"
fi

echo "<div class=\"accordion\">
  <div class=\"block\">
    <button class=\"opener\">Anmelden</button>
    <div class=\"content\">
      <form method=\"POST\" action=\"login.sh\">
        <p>E-Mail: <input type=\"email\" name=\"email\" placeholder=\"E-Mail\" required></p>
        <p>Passwort: <input type=\"password\" name=\"password\" placeholder=\"Passwort\" required></p>
        <p><button type=\"submit\">Login</button></p>
      </form>
    </div>
  </div>
  <div class=\"block\">
    <button class=\"opener\">Registrieren</button>
    <div class=\"content\">
      <form method=\"POST\" action=\"register.sh\">
        <p>Name: <input type=\"text\" name=\"name\" placeholder=\"Name\" required></p>
        <p>E-Mail: <input type=\"email\" name=\"email\" placeholder=\"E-Mail\" required></p>
        <p>Passwort: <input type=\"password\" name=\"password\" placeholder=\"Passwort\" required></p>
        <p>Passwort bestätigen: <input type=\"password\" name=\"confirm_password\" placeholder=\"Passwort bestätigen\" required></p>
        <p><button type=\"submit\">Registrieren</button></p>
      </form>
    </div>
  </div>
</div>"
