import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.FileReader;
import javax.json.Json;
import javax.json.JsonReader;
import javax.json.JsonStructure;

public class BenchmarkLoader implements AutoCloseable {

	Connection con;
	PreparedStatement insertStatement;
	PreparedStatement maxRepetionStatement;
	PreparedStatement indexKeyStatement;
	PreparedStatement hintKeyStatement;
	PreparedStatement queryKeyStatement;

	public BenchmarkLoader(String host, int instance, String database, String user, String password)
			throws SQLException {
		con = DriverManager.getConnection("jdbc:sap://" + host + ":3" + instance + "13/?databaseName=" + database
				+ "&autocommit=false&currentSchema=BENCHMARKS", user, password);
		insertStatement = con.prepareStatement(
				"INSERT INTO MEASUREMENTS (M_ScaleFactor, M_Column, M_IndexConfigKey, M_CpuCount, M_ThreadCount, M_HintKey, M_QueryKey, M_Repetition, M_RunTime, M_CursTIme) VALUES(?,?,?,?,?,?,?,?,?,?)");
		maxRepetionStatement = con.prepareStatement(
				"SELECT IFNULL(MAX(M_Repetition),0) FROM Measurements WHERE M_ScaleFactor=? AND M_Column=? AND M_IndexConfigKey=? AND M_CpuCount=? AND M_ThreadCount=? AND M_HintKey=? AND M_QUERYKEY=?");
		indexKeyStatement = con.prepareStatement("SELECT I_ConfigKey FROM indices WHERE I_ConfigName=?");
		hintKeyStatement = con.prepareStatement("SELECT H_HintKey FROM hints WHERE H_HintName=?");
		queryKeyStatement = con.prepareStatement("SELECT Q_QueryKey FROM queries WHERE Q_Query=?");
	}

	private PreparedStatement setDims(PreparedStatement ps, int scaleFactor, boolean column, int indexKey, int cpu,
			int thread, int hintKey, int queryKey) throws SQLException {
		ps.setInt(1, scaleFactor);
		ps.setBoolean(2, column);
		ps.setInt(3, indexKey);
		ps.setInt(4, cpu);
		ps.setInt(5, thread);
		ps.setInt(6, hintKey);
		ps.setInt(7, queryKey);
		return ps;
	}

	private int getKey(PreparedStatement ps, String val) throws SQLException {
		ps.setString(1, val);
		try (ResultSet rs = ps.executeQuery()) {
			if (!rs.next()) {
				// create dim entry
			}
			return rs.getInt(1);
		}
	}

	public void insertRepetitions(int scaleFactor, boolean column, String indexConfig, int cpu, int thread, String hint,
			String query, Measurement[] repetitionts) throws SQLException {

		indexKeyStatement.setString(1, indexConfig);
		hintKeyStatement.setString(1, hint);
		queryKeyStatement.setString(1, query);
		int indexKey = getKey(indexKeyStatement, indexConfig);
		int hintKey = getKey(hintKeyStatement, hint);
		int queryKey = getKey(queryKeyStatement, query);
		setDims(maxRepetionStatement, scaleFactor, column, indexKey, cpu, thread, hintKey, queryKey);

		int lastRepetition;
		try (ResultSet rs = maxRepetionStatement.executeQuery()) {
			rs.next();
			lastRepetition = rs.getInt(1);
		}

		setDims(insertStatement, scaleFactor, column, indexKey, cpu, thread, hintKey, queryKey);

		for (Measurement m : repetitionts) {
			lastRepetition++;
			insertStatement.setInt(8, lastRepetition);
			insertStatement.setInt(9, m.getServerTime());
			insertStatement.setInt(10, m.getCurserTime());
			insertStatement.addBatch();
		}
		insertStatement.executeBatch();
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
		if (args.length < 5) {
			System.out.println("Usage: BenchmarkLoader host instance database user password");
			System.exit(-1);
		}

		try (BenchmarkLoader bl = new BenchmarkLoader(args[0], Integer.parseInt(args[1]), args[2], args[3], args[4])) {
			Measurement[] m = { new Measurement(100, 10), new Measurement(110, 20) };
			bl.insertRepetitions(1, true, "NONE", 8, 8, "NONE", "1.1", m);
			bl.con.commit();
		}
	}
}
