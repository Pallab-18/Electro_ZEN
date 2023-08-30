<%@page import="com.ecom.helper.FactoryProvider" %>
<%@page import="com.ecom.helper.Helper" %>
<%@ page import="java.util.List" %>

<%@page import="com.ecom.DAO.ProductDao" %>
<%@page import="com.ecom.entities.Product" %>

<%@page import="com.ecom.DAO.CategoryDao" %>
<%@page import="com.ecom.entities.Category" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ElectroZEN - Home</title>
        <%@include file="components/common_css_js.jsp"  %>

    </head>
    <body>

        <%@include file="components/navbar.jsp" %>



        <div class="container-fluid">


            <div class="container-lg py-4">


                <div class="row">

                    <div class="col-md-10 offset-md-1">

                        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">

                            <ol class="carousel-indicators">
                                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                            </ol>

                            <div class="carousel-inner p-1">

                                <div class="carousel-item active bg-dark shadow-sm rounded p-4 mb-5 " data-interval="500">
                                    <h3 class="text-center text-white">Welcome to ElectroZEN</h3>
                                    <p class="text-white">When it comes to the market of all the necessary electronics products in a single 
                                    frame then there is nothing better than ElectroZEN.It was created and developed by Mr.Pallab Chatterjee
                                    a final year Electronics and Communication Engineering student from Asansol Engineering College.You can 
                                    give your valuable reviews to his site and purchase your favourite products with an exciting discount 
                                    and share love and regards.
                                   </p>
                                   <h6 class="text-center text-white">Thank you for visiting the website</h6>
                                </div>

                                <div class="carousel-item bg-dark shadow-sm rounded p-4 mb-5" data-interval="500">
                                    <p class="text-center text-white">This is second carousel</p>
                                    <p class="text-white">Contrary to popular belief, Lorem Ipsum is not simply random text.
                                        It has roots in a piece of classical Latin literature from 45 BC, making it over 2000
                                        years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia,
                                        looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage,
                                        and going through the cites of the word in classical literature, discovered the 
                                        undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus
                                        Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This
                                        book is a treatise on the theory of ethics, very popular during the Renaissance. The first
                                        line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.</p>
                                </div>

                                <div class="carousel-item bg-dark shadow-sm rounded p-4 mb-5" data-interval="500">
                                    <p class="text-center text-white">This is third carousel</p>
                                    <p class="text-white">Contrary to popular belief, Lorem Ipsum is not simply random text.
                                        It has roots in a piece of classical Latin literature from 45 BC, making it over 2000
                                        years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia,
                                        looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage,
                                        and going through the cites of the word in classical literature, discovered the 
                                        undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus
                                        Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This
                                        book is a treatise on the theory of ethics, very popular during the Renaissance. The first
                                        line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.</p>
                                </div>

                            </div>

                            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>



                        </div>
                    </div>
                </div>
            </div>






            <div class="row mt-3 mx-2">

                <!--fetching the products-->

                <%
                    String cat = request.getParameter("category");
                    //out.println(cat);
                    
                
                   ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                   //List<Product> plist = pdao.getAllProducts();
                   
                
                    List<Product> plist=null;
                    if(cat == null || cat.trim().equals("all")) 
                    {
                      plist = pdao.getAllProducts();
                    }
                   else
                   {
                     int cid=Integer.parseInt(cat.trim());
                     plist=pdao.getAllProductsById(cid);
                   }
                   
               
                   
                   
                   CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
                   List<Category> clist=cdao.getCategories();
                
                %>




                <!--show categories-->
                <div class="col-md-2">

                    <div class="list-group mt-4">

                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                            All Products
                        </a>


                        <%
                    
                            for(Category c:clist)
                            {
                        %>   

                        <a href="index.jsp?category=<%= c.getCategoryId() %>" class="list-group-item list-group-item-action"> <%= c.getCategoryTitle() %></a>

                        <%       
                            }
                
                        %>

                    </div>

                </div>

                <!--show products-->

                <div class="col-md-10">

                    <!--row-->
                    <div class="row mt-4">

                        <div class="col-md-12">

                            <div class="card-columns">

                                <!--traversing products-->
                                <%
                                    for(Product p:plist)
                                    {   
                                %>

                                <!--product card-->
                                <div class="card product-card">

                                    <div class="container text-center">
                                        <img class="card-img-top m-2" src="img/products/<%= p.getpPhoto() %>" style="max-height: 220px; max-width: 100%; width: auto;" alt="Card image cap">
                                    </div>

                                    <div class="card-body"> 
                                        <h5 class="card-title"><%= p.getpName() %></h5>

                                        <p class="card-text">
                                            <%= Helper.get10Words(p.getpDesc()) %>
                                    </div>

                                    <div class="card-footer text-center">
                                        <button class="btn custom-bg text-black" onclick="add_to_cart(<%= p.getpId() %>, '<%= p.getpName() %>',<%= p.getPriceAfterApplyingDiscount() %>)">Add To Cart</button>
                                        <button class="btn btn-outline-primary text-black">&#x20B9;<%= p.getPriceAfterApplyingDiscount() %>/- <span class="text-secondary discount-label"> &#x20B9;<%= p.getpPrice() %> , <%= p.getpDiscount() %>%off</span> </button>

                                    </div>


                                </div>



                                <%
                                    }

                                     if(plist.size() == 0)
                                    {
                                       out.println("<h3>No item in this category</h3>");
                                    }

                                %>



                            </div>

                        </div>

                    </div>



                </div>

            </div>




        </div>

        <%@include file="components/common_modals.jsp" %>                    
    </body>
</html>
