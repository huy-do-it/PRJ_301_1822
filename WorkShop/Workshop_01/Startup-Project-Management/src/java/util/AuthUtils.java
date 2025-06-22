package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author ddhuy
 */
public class AuthUtils {

    public static User getCurrentUser(HttpServletRequest request) {
        HttpSession sesstion = request.getSession();
        if (sesstion != null) {
            return (User) sesstion.getAttribute("user");
        }
        return null;
    }

    public static boolean isLoggedIn(HttpServletRequest request) {
        return getCurrentUser(request) != null;
    }
    
    public static boolean hasRole(HttpServletRequest request, String role){
        User user = getCurrentUser(request);
        if(user != null)
            return user.getRole().equals(role);
        return false;
    }
    
    public static String getLoginURL(){
        return "MainController";
    }
    
    public static boolean isAdmin(HttpServletRequest request){
        return hasRole(request, "AD");
    }
    
    public static boolean isManager(HttpServletRequest request){
        return hasRole(request, "MA");
    }
    
    public static boolean isMember(HttpServletRequest request){
        return hasRole(request, "MB");
    }
    
    public static String getAccessDeniedMessage(String action){
        return "You cannnot access to " + action + ". Please contact Adminstrator to know more detail information.";
    }
}
