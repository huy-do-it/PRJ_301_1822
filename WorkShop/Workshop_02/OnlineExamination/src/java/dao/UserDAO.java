/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import util.DBUtils;

/**
 *
 * @author ddhuy
 */
public class UserDAO {
    
    public boolean isLogin (String userName, String password){
        User user = getUserbyUserName(userName);
        
        return (user != null && user.getPassword().equals(password));
    }
    
    public User getUserbyUserName (String userName){
        User user = null;
        String query = "SELECT * FROM tblUsers WHERE username = ? ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, userName);
            
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                user = new User(
                        rs.getString("username"),
                        rs.getString("Name"),
                        rs.getString("password"),
                        rs.getString("Role"));
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return user;
    }
}
