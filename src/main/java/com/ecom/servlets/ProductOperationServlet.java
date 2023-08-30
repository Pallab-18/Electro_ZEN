package com.ecom.servlets;

import com.ecom.entities.*;
import com.ecom.DAO.CategoryDao;
import com.ecom.DAO.ProductDao;
import com.ecom.entities.Category;
import com.ecom.helper.FactoryProvider;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            /*  
          servlet do 2 work:
          add category
          add products */
//          =================================================================================================  
            String op = request.getParameter("operation");

            if (op.trim().equals("addcategory")) {

                //add category
                //fetching category data
                String title = request.getParameter("catTitle");
                String description = request.getParameter("catDescription");

                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(description);

                //save the category in database
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);
                //out.println("Category Saved");

                //print the message at the page that db is saved or not 
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Category added successfully !! Category Id is " + catId);
                response.sendRedirect("admin.jsp");
                return;

            } //        =====================================================================================================================
            else if (op.trim().equals("addproduct")) {
                //Add Product

                String pName = request.getParameter("pName");
                String pDesc = request.getParameter("pDesc");
                int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));

                //for file
                Part part = request.getPart("pPic");

                Product p = new Product();
                p.setpName(pName);
                p.setpDesc(pDesc);
                p.setpPrice(pPrice);
                p.setpDiscount(pDiscount);
                p.setpQuantity(pQuantity);
                p.setpPhoto(part.getSubmittedFileName());

                //get category by id
                CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
                Category category = cDao.getCategoryById(catId);

                p.setCategory(category);

                //save the product...
                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                pdao.saveProduct(p);

                try {

                    //****pic upload****
                    //  find out the path to upload the photo
                    String s = request.getServletContext().getRealPath("/img") + File.separator + "products" + File.separator + part.getSubmittedFileName();
                    System.out.println(s);

                    //uploading code
                    FileOutputStream fos = new FileOutputStream(s);
                    InputStream is = part.getInputStream();

                    // reading data
                    byte[] data = new byte[is.available()];
                    is.read(data);

                    //writing the data
                    fos.write(data);
                    fos.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }

                //out.println("Product save success...");
                //print the message at the page that db is saved or not 
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Product is added successfully !!");
                response.sendRedirect("admin.jsp");
                return;

            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
