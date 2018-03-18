import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BenchmarkLoader implements AutoCloseable {

	Connection con;
	PreparedStatement insertStatement;
	PreparedStatement maxRepetionStatement;

	public BenchmarkLoader(String host, int instance, String database, String user, String password)
			throws SQLException {
		con = DriverManager.getConnection(
				"jdbc:sap://" + host + ":3+" + instance + "15/?databaseName=" + database + "&autocommit=false&currentSchema=BENCHMARKS", user,
				password);
		insertStatement = con.prepareStatement("INSERT INTO MEASUREMENTS (M_ScaleFactor, M_IndexConfigKey, M_Column, M_CpuCount, M_ThreadCount, M_HintKey, M_QueryKey M_Repetition, M_RunTime, M_CursorTIme) (?,(SELECT?,?,?,?,?,?,?,?)");
		maxRepetionStatement = con.prepareStatement("SELECT IFNULL(MAX(M_Repetition),0) WHERE M_ScaleFactor=? AND M_IndexConfigKey=? AND M_Column=? AND M_CpuCount=? AND M_ThreadCount=? AND M_HintKey=? AND M_QUERYKEY=?");
	}

	private void setDims(PreparedStatement ps) {
		
	}
	
	public void insertRun(int scaleFactor, boolean column, int cpu, int thread, String indexConfig, String hint, String query, Measurement[] repetitionts) throws SQLException {
		int lastRepetition=maxRepetionStatement.executeQuery().getInt(0);
		for(Measurement m : repetitionts) {
			lastRepetition++;
			insertStatement.setInt(0, scaleFactor);
			insertStatement.setInt(1, x);
		}
	}

	@Override
	public void close() throws Exception {
		try {
			insertStatement.close();
		} finally {
			con.close();
		}
	}

	public static void main(String[] args) throws Exception {
		if (args.length < 3) {
			System.out.println("Usage: BenchmarkLoader host instance database user password");
			System.exit(-1);
		}

		try (BenchmarkLoader bl = new BenchmarkLoader(args[0], Integer.parseInt(args[1]), args[3], args[4], args[5])) {

		}
	}
}
