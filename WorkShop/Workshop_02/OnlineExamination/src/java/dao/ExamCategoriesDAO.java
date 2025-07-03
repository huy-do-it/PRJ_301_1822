/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ExamCategories;
import util.DBUtils;

/**
 *
 * @author ddhuy
 */
public class ExamCategoriesDAO {

    public List<ExamCategories> getAll() {

        String query = "SELECT * FROM tblExamCategories ";

        List<ExamCategories> list = new ArrayList();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                ExamCategories exam = new ExamCategories(
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        rs.getString("description"));
                list.add(exam);
            }

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ExamCategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, ps, rs);
        }

        return list;
    }

    public ExamCategories getById(int catId) {
        String query = "SELECT * FROM tblExamCategories WHERE category_id = ? ";
                
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, catId);
            
            rs = ps.executeQuery();

            if (rs.next()) {
                return new ExamCategories(
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        rs.getString("description")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return null;
    }

    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing resources: " + e.getMessage());
            e.printStackTrace();
        }
    }

    

}
