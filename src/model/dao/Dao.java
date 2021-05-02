package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.nio.file.Paths;

import model.Asiakas;

public class Dao {
	
		private Connection con=null;
		private ResultSet rs = null;
		private PreparedStatement stmtPrep=null; 
		private String sql;
		private String db ="Myynti.sqlite";
		
		private Connection yhdista(){		
	    	Connection con = null;
	    	//String myPath = Paths.get(".").toAbsolutePath().normalize().toString();
	    	 // String path = System.getProperty("user.dir")+"/";
	    	//System.out.println(myPath);
	    	String path = "C:/Users/Sini.DESKTOP-BV98MFD/eclipse-workspace/";
	    	String url = "jdbc:sqlite:"+path+db;    	
	    	try {	       
	    		Class.forName("org.sqlite.JDBC");
		        con = DriverManager.getConnection(url);	
		        System.out.println("Yhteys avattu.");
		     }catch (Exception e){	
		    	 System.out.println("Yhteyden avaus epäonnistui.");
		        e.printStackTrace();	         
		     }
		     return con;
		}
	
	public ArrayList<Asiakas> listaaKaikki(){
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "SELECT * FROM asiakkaat";
		try {
			con = yhdista();
			if (con!=null) {
				stmtPrep = con.prepareStatement(sql);
				rs = stmtPrep.executeQuery();
				if (rs!=null) {
					while (rs.next()) {
						Asiakas asiakas = new Asiakas();
						asiakas.setEtunimi(rs.getString(1));
						asiakas.setSukunimi(rs.getString(2));
						asiakas.setPuhelin(rs.getString(3));
						asiakas.setSposti(rs.getString(4));
						asiakkaat.add(asiakas);
					}
				}
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return asiakkaat;
	}
	

}
