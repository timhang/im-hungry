<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "API.*, java.util.*, org.json.*, javax.servlet.http.HttpServlet, javax.servlet.http.HttpServletRequest"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Results Page</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="resultsPage.css" />
		<style>
  			#img1{
				width: 150px;
				height: 150px;
				}
				.image{
				display: inline-block;
				}
  		</style>
	</head>
	
	<body>
		<div class="container-fluid">
		<!-- Row for photo collage and buttons -->
		  <div class="row">
		  </br>
		  	<!-- Photo collage column -->
		    <div class="col-lg-8">
		    	
					<%
					if(request.getParameter("searchText") != ImageAPI.getSearchTerm()){
						ImageAPI.setState(false);
					}
					ArrayList<String> imgArr;
					if(ImageAPI.getState() == false){
				    	imgArr = ImageAPI.call_me(request.getParameter("searchText"));
				    	System.out.println(request.getParameter("numberType"));
				    	ImageAPI.setState(true);
					} else {
						imgArr = ImageAPI.getImageArray();
					}
					
					for (int i = 0; i < imgArr.size(); i++) {
						
						out.println("<img src = "+ imgArr.get(i)+" id = img1>");
			    		
					}
			       %>
			    
		    </div>
		    <!-- Button column -->
		    <div class="col-lg-4">
		    	<div>
					<select id="mySelect">
					  <option></option>
					  <option value="favorites.jsp">Favorites</option>
					  <option value="toExplore.jsp">To Explore</option>
					  <option value="doNotShow.jsp">Do Not Show</option>
					</select>
				</div></br>
				<button type="button" onclick="manageList()">Manage List</button></br></br>
				<button onclick="returnToSearch()">Return to Search Page</button>
		    </div>
		  </div>
		  <!-- Row for Restaurant and Recipe table -->
		  <div class="row">
		    <div class="col-lg-12">
		    	<h1 id="title">Results For "<span id="searchText"></span>"</h1>
				<script type='text/javascript'>
					document.getElementById('searchText').innerHTML = sessionStorage.getItem('searchText');
				</script>
				<%-- <div class = "resultsTable" align = "center">
					<table style="width:100%">
						<tr>
							<th style="font-size: 30px;">Restaurant</th>
							<th style="font-size: 30px;">Recipe</th>
						</tr>
						<%
						
				    	
						HashMap<Integer, Recipe> allRecipes = RecipeAPI.call_me("burger",5);
						
						
						ArrayList<Integer> recipeIds = RecipeAPI.getRecipeId();
						
				    	System.out.println(allRecipes.size());
				    	
				    	for (int i = 0; i < recipeIds.size(); i++) {
							out.println("<tr>");
							out.println("<td><a href= restPage.jsp>Blaze Pizza</a></td>");
							out.println("<td><div>");
							out.println("Name: " + allRecipes.get(recipeIds.get(i)).getName()+"</br>");
							out.println("Stars: " + allRecipes.get(recipeIds.get(i)).getStarRating()+"</br>");
							out.println("Prep time: " + allRecipes.get(recipeIds.get(i)).getPrepTime() + " Cook time: " + allRecipes.get(recipeIds.get(i)).getCookTime()+"</br>");
							out.println("</div></td>");
							out.println("</tr>");
						}
				       %>
			       </table>
				</div> --%>
				
				<div class="resultsTable" align="center">
					<table style="width:100%">
						<tr>
							<th style="font-size: 30px;">Restauraunt</th>
							<th style="font-size: 30px;">Recipe</th>
						</tr>
						<tr>
						    <td><a href="restPage.jsp">Blaze Pizza</a></td>
						    <td><a href="recipePage.jsp">Margherita Pizza</a></td>
						</tr>
						<tr>
						    <td>Bon Shabu</td>
						    <td>Hotpot</td>
						</tr>
						<tr>
						    <td>Meat Love</td>
						    <td>Korean Barbeque</td>
						</tr>
						<tr>
						    <td>Filler</td>
						    <td>Filler</td>
						</tr>
						<tr>
						    <td>Filler</td>
						    <td>Filler</td>
						</tr>
						<tr>
						    <td>Filler</td>
						    <td>Filler</td>
						</tr>
						<tr>
						    <td>Filler</td>
						    <td>Filler</td>
						</tr>
						<tr>
						    <td>Filler</td>
						    <td>Filler</td>
						</tr>
					</table>
				
				</div>
		    </div>
		  </div>
		</div>
	
		<script>		 
			function returnToSearch() {
				window.location.href = 'searchPage.html';
			}
			function manageList() {
				var link = document.getElementById("mySelect").selectedIndex;
				if(link == "1"){
					window.location.href = 'favorites.jsp';
				}	
				else if(link == "2"){
					window.location.href = 'toExplore.jsp';
				}
				else if(link == "3"){
					window.location.href = 'doNotShow.jsp';
				}
			}
		</script>
	</body>
</html>