
public class Measurement {

	private int serverTime;
	private int curserTime;
	
	public Measurement(int serverTime, int curserTime) {
		super();
		this.serverTime = serverTime;
		this.curserTime = curserTime;
	}
	
	public int getServerTime() {
		return serverTime;
	}
	public int getCurserTime() {
		return curserTime;
	}
}
