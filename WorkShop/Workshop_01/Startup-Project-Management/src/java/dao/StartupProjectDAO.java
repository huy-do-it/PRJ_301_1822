package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.StartupProject;
import util.DBUtils;

/**
 *
 * @author ddhuy
 */
public class StartupProjectDAO {

    private static final String GET_ALL_PROJECT = "SELECT * FROM tblStartupProjects ";
    private static final String UPDATE_PRODUCT = "UPDATE tblStartupProjects SET [project_name] = ?, [Description] = ?, [Status] = ?, [estimated_launch] = ? WHERE project_id = ? ";
    private static final String CREATE_PRODUCT = "INSERT INTO tblStartupProjects (project_id, project_name, Description, Status, estimated_launch) VALUES (?, ?, ?, ?, ?) ";

    public List<StartupProject> getAll() {

        List<StartupProject> projects = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_PROJECT);
            rs = ps.executeQuery();
            while (rs.next()) {
                StartupProject project = new StartupProject(
                        rs.getInt("project_id"),
                        rs.getString("project_name"),
                        rs.getString("Description"),
                        rs.getString("Status"),
                        rs.getDate("estimated_launch"));
                projects.add(project);
            }
        } catch (Exception e) {
            System.err.println("Error in getAll(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return projects;
    }

    

    public List<StartupProject> getProjectByName(String keyword) {

        String query = GET_ALL_PROJECT + "WHERE project_name LIKE ? OR Description LIKE ? ";

        List<StartupProject> projects = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                StartupProject project = new StartupProject(
                        rs.getInt("project_id"),
                        rs.getString("project_name"),
                        rs.getString("Description"),
                        rs.getString("Status"),
                        rs.getDate("estimated_launch"));
                projects.add(project);
            }
        } catch (Exception e) {
            System.err.println("Error in getAll(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return projects;
    }

    public boolean update(StartupProject project) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(UPDATE_PRODUCT);

            ps.setString(1, project.getProjectName());
            ps.setString(2, project.getDescription());
            ps.setString(3, project.getStatus());
            ps.setDate(4, project.getEstimatedLaunch());
            ps.setInt(5, project.getProjectId());

            success = (ps.executeUpdate() > 0);

        } catch (Exception e) {
            System.err.println("Error in update(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }

        return success;
    }
    

    public int CreateId() {
        String query = "SELECT MAX(project_id) as max_id FROM tblStartupProjects ";
        int projectId = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                projectId = rs.getInt("max_id");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(StartupProjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }finally {
            closeResources(conn, ps, rs);
        }
        
        return projectId;
    }
    
    public boolean Create(StartupProject sp) {
        
        Connection conn = null;
        PreparedStatement ps = null;
        boolean success = false;
        
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(CREATE_PRODUCT);
            
            ps.setInt(1, sp.getProjectId());
            ps.setString(2, sp.getProjectName());
            ps.setString(3, sp.getDescription());
            ps.setString(4, sp.getStatus());
            ps.setDate(5, sp.getEstimatedLaunch());
            
            success = (ps.executeUpdate() > 0); 
            
        } catch (Exception e) {
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }
    
    /**
     * Close database resources safely
     *
     * @param conn Connection to close
     * @param ps PreparedStatement to close
     * @param rs ResultSet to close
     */
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
