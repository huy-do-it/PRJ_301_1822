/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.UserDTO;

/**
 *
 * @author ddhuy
 */
public class AuthUtils {

    public static UserDTO getCurrentUser(HttpServletRequest request) {
        HttpSession sesstion = request.getSession();
        if (sesstion != null) {
            return (UserDTO) sesstion.getAttribute("user");
        }
        return null;
    }

    public static boolean isLoggedIn(HttpServletRequest request) {
        return getCurrentUser(request) != null;
    }
    
    public static boolean hasRole(HttpServletRequest request, String role){
        UserDTO user = getCurrentUser(request);
        if(user != null)
            return user.getRoleID().equals(role);
        return false;
    }
    
    public static String getLoginURL(){
        return "MainController";
    }
    
    public static boolean isAdmin(HttpServletRequest request){
        return hasRole(request, "AD");
    }
    
    public static boolean isMember(HttpServletRequest request){
        return hasRole(request, "MB");
    }
    
    public static String getAccessDeniedMessage(String action){
        return "You cannnot access to " + action + ". Please contact Adminstrator to know more detail information.";
    }
}
