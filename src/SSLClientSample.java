import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URLConnection;

import javax.net.ssl.HttpsURLConnection;

public class SSLClientSample {
	public static void main(String[] argv) throws Exception {

		if (argv.length == 0) {
			System.out.print("Usage:");
			System.out.print(" java SSLClientSample https://test-url");
			System.exit(1);
		}

		URI uri = new URI(argv[0]);
		URLConnection connection = uri.toURL().openConnection();

		HttpsURLConnection sslconnection = (HttpsURLConnection)connection;
		System.out.println();

		BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		String buffer = reader.readLine();
		while (null != buffer) {
			System.out.println(buffer);
			buffer = reader.readLine();
		}

		System.exit(0);

	}
}