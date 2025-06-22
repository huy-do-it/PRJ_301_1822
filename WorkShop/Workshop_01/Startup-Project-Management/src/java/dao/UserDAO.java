package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;
import util.DBUtils;

/**
 *
 * @author ddhuy
 */
public class UserDAO {

    public UserDAO() {
    }

    public boolean isLogin(String userName, String password) {
        User user = getUserByUserName(userName);
        return (user != null && user.getPassword().equals(password));

    }

    public User getUserByUserName(String usernName) {
        User user = null;
        try {
            String query = "SELECT * FROM tblUsers WHERE Username = ? ";
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, usernName);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User(rs.getString("Username"),
                        rs.getString("Name"),
                        rs.getString("Password"),
                        rs.getString("Role"));
            }
        } catch (Exception e) {
        }
        return user;
    }
}
