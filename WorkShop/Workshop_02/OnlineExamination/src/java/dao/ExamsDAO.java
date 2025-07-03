package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Exam;
import model.ExamCategories;
import org.apache.jasper.tagplugins.jstl.core.Catch;
import util.DBUtils;

/**
 *
 * @author ddhuy
 */
public class ExamsDAO {

    public List<Exam> getExamsByCategoryId(int categoryId) {
        List<Exam> list = new ArrayList<>();
        String sql = "SELECT * FROM tblExams WHERE category_id = ?";

        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Exam exam = new Exam(
                        rs.getInt("exam_id"),
                        rs.getString("exam_title"),
                        rs.getString("Subject"),
                        rs.getInt("category_id"),
                        rs.getInt("total_marks"),
                        rs.getInt("Duration")
                );
                list.add(exam);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean createExam(Exam e) {
        String sql = "INSERT INTO tblExams(exam_id, exam_title, Subject, category_id, total_marks, Duration) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, e.getExamId());
            ps.setString(2, e.getExamTitle());
            ps.setString(3, e.getSubject());
            ps.setInt(4, e.getCategoryId());
            ps.setInt(5, e.getTotalMarks());
            ps.setInt(6, e.getDuration());
            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public int CreateId() {
        String query = "SELECT MAX(exam_id) AS maxId FROM tblExams";
        int examId = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                examId = rs.getInt("maxId") + 1;
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ExamsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, ps, rs);
        }

        return examId;
    }

    public Exam getExamById(int examId) {
        String sql = "SELECT * FROM tblExams WHERE exam_id = ?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, examId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Exam(
                        rs.getInt("exam_id"),
                        rs.getString("exam_title"),
                        rs.getString("Subject"),
                        rs.getInt("category_id"),
                        rs.getInt("total_marks"),
                        rs.getInt("Duration")
                );
            }
        } catch (Exception ex) {
            ex.printStackTrace();
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
