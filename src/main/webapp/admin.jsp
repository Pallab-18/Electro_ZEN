<%@ page import="java.util.List" %>
<%@page import="com.ecom.DAO.CategoryDao" %>
<%@page import="com.ecom.entities.Category" %>
<%@page import="com.ecom.helper.FactoryProvider" %>
<%@page import="com.ecom.entities.User" %>

<%
    User user=(User)session.getAttribute("current_user");
    if(user==null)
    {
       session.setAttribute("message","You are not logged in !! Login first");
       response.sendRedirect("login.jsp");
       return;
    }
    else
    {
       if(user.getUserType().equals("normal"))
       {
         session.setAttribute("message","You are not admin !! Do not access this page");
         response.sendRedirect("login.jsp");
         return;
       
       }
    
    }

%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>


        <div class="container admin">


            <!--print message that db is saved or any problem occurs-->
            <div class="container-fluid mt-3">     
                <%@include file="components/message.jsp" %>               
            </div>



            <!--first row-->
            <div class="row mt-3">

                <!--first column-->
                <div class="col-md-4">

                    <div class="card">
                        <div class="card-body text-center"> 

                            <div class="container">
                                <img style="max-width: 120px" class="img-fluid rounded-circle" src="img/team.png">
                            </div>

                            <h1>234</h1>
                            <h1 class="text-uppercase text-muted" >Users</h1>
                        </div>
                    </div>

                </div>

                <!--second column-->
                <div class="col-md-4">

                    <div class="card">  
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 120px" class="img-fluid" src="img/list.png">
                            </div>
                            <h1>54</h1>
                            <h1 class="text-uppercase text-muted" >Categories</h1>

                        </div>    
                    </div>

                </div>

                <!--third column-->
                <div class="col-md-4">

                    <div class="card">
                        <div class="card-body text-center"> 

                            <div class="container">
                                <img style="max-width: 120px" class="img-fluid rounded-circle" src="img/delivery-service.png">
                            </div>

                            <h1>590</h1>
                            <h1 class="text-uppercase text-muted" >Products</h1>                     
                        </div>        
                    </div>

                </div>

            </div>

            <!--second row-->
            <div class="row mt-3">

                <div class="col-md-6">

                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center"> 

                            <div class="container">
                                <img style="max-width: 120px" class="img-fluid" src="img/add.png">
                            </div>

                            <p class="mt-2"> Click here to add new category </p>
                            <h1 class="text-uppercase text-muted" >Add Category</h1>                     
                        </div>        
                    </div>

                </div>

                <div class="col-md-6">

                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center"> 

                            <div class="container">
                                <img style="max-width: 120px" class="img-fluid rounded-circle" src="img/plus.png">
                            </div>

                            <p class="mt-2"> Click here to add new products </p>
                            <h1 class="text-uppercase text-muted" >Add products</h1>                     
                        </div>        
                    </div>
                </div>

            </div>


        </div>

    
   <!--============================================================-->
            

        <!--start add category modal-->



        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post">

                            <!--for servlet to recognize which operation to be done-->
                            <input type="hidden" name="operation" value="addcategory">


                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required />   
                            </div>

                            <div class="form-group">
                                <textarea style="height: 250px" class="form-control" placeholder="Enter category description" name="catDescription" required></textarea>
                            </div>


                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>  


                    </div>


                </div>
            </div>
        </div>


        <!--end add category modal-->


        <!--========================================================-->

        <!--start add product modal-->


        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                       <!--start form--> 
                        
                       
                       <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                           
                           <!--check for the operation in servlet-->
                           <input type="hidden" name="operation" value="addproduct"/>
                           
                           
                           
                          <!--product title-->
                          <div class="form-group">
                              <input type="text" name="pName" class="form-control" placeholder="Enter title of the product" required/>
                          </div>
                           
                          <!--product description-->
                          <div class="form-group">
                              <textarea style="height: 100px" class="form-control" name="pDesc" placeholder="Enter product description"></textarea>
                          </div>
                          
                          <!--product price-->
                          <div class="form-group">
                              <input type="number" name="pPrice" class="form-control" placeholder="Enter price of the product" required/>
                          </div>
                          
                          <!--product discount-->
                          <div class="form-group">
                              <input type="number" name="pDiscount" class="form-control" placeholder="Enter product discount" required/>
                          </div>
                          
                          <!--product quantity-->
                          <div class="form-group">
                              <input type="number" name="pQuantity" class="form-control" placeholder="Enter quantity of the product" required/>
                          </div>
                          
                          
                          <!--product categories : which is basically comes from database-->
                        
                          <% 
                              
                             CategoryDao cDao=new CategoryDao(FactoryProvider.getFactory());
                             List<Category> list=cDao.getCategories();
                          
                          %>
                          
                         
                          <div class="form-group">
                              <select name="catId" class="form-control">
                                  
                                   <%
                                       for(Category c:list)
                                       {
                                
                                   %>
                                     
                                        <option value="<%= c.getCategoryId() %>"> <%= c.getCategoryTitle() %></option>
                                   
                                   <% 
                                       } 
                                   %>
                                  
                              </select> 
                          </div>
                          
                          <!--product file-->     
                          <div class="form-group">
                              <label for="pPic">Select Picture of Product</label> <br>
                              <input type="file" id="pPic" name="pPic" required/> 
                          </div>
                          
                          <!--submit button-->
                          <div class="container text-center">
                              <button class="btn btn-outline-success">Add Product</button>
                          </div>
                           
                       </form>
                       
                       
                        <!--end form-->
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        
                    </div>
                </div>
            </div>
        </div>

        <!--end add product modal-->


    </body>
</html>
