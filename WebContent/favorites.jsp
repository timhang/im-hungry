<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "API.*, java.util.*, org.json.*, javax.servlet.http.HttpServlet, javax.servlet.http.HttpServletRequest"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Favorites</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	 	<link rel="stylesheet" type="text/css" href="favorites.css" />
	 	
	</head>
	<body>
	<%
		ArrayList<Integer> recipeIds = RecipeAPI.getRecipeId();
		ArrayList<Integer> restIds = RestAPI.getRestIDs();
		HashMap<Integer, Recipe> recipeMap = RecipeAPI.getRecipeMap();
		HashMap<Integer, Restaurant> restMap = RestAPI.getRestaurantMap();
		ArrayList<Integer> recipeInList = new ArrayList<Integer>();
		ArrayList<Integer> restInList = new ArrayList<Integer>();
		for(int i = 0 ; i < recipeIds.size(); i++){
			if(recipeMap.get(recipeIds.get(i)).getFavorite() == true){
				recipeInList.add(recipeIds.get(i));
			}
		}
		for(int i = 0 ; i < restIds.size(); i++){
			if(restMap.get(restIds.get(i)).getFavorite() == true){
				restInList.add(restIds.get(i));
			}
		}
		System.out.println(recipeInList.size());
		System.out.println(restInList.size());
	%>
		<div class="container-fluid">
		 <h1 id="title">Favorites</h1>
		  <div class="row">
		  	<!-- Column for list of restaurants and recipes -->
		    <div class="col-lg-8">
		    	<div class="listTable">
			    	<table style="width:100%">
			    		<tbody>
				    	
				    		<%
							
							// Loop through all of the restauraunts and display based on true/false boolean
							  for (int i = 0; i < restInList.size(); i++) {
								  String name = restMap.get(restIds.get(i)).getName();
								  String address = restMap.get(restIds.get(i)).getAddress();
								  double rating = restMap.get(restIds.get(i)).getRating();
								  String link = "restPage.jsp?restaurantId="+ restIds.get(i);
							%>
								<tr><td><div>
									<a href = <%= link %> >
							    		<%= name %>
									</a><br>
									Address: <%= address %><br>
									Distance: Need to Calculate<br>
									Stars: <%= rating %><br>
								</div></td></tr>
							<%
							  }
							%>
				    	
				    	
							<%
							
							// Loop through all of the recipes and display based on true/false boolean
							  for (int i = 0; i < recipeInList.size(); i++) {
								  String name = recipeMap.get(recipeIds.get(i)).getName();
								  float starRating = recipeMap.get(recipeIds.get(i)).getStarRating();
								  int prepTime = recipeMap.get(recipeIds.get(i)).getPrepTime();
								  int cookTime = recipeMap.get(recipeIds.get(i)).getCookTime();
								  String link = "recipePage.jsp?recipeId="+ recipeIds.get(i);
							%>
								<tr><td><div>
									<a href = <%= link %> >
							    		<%= name %>
									</a><br>
									Stars: <%= starRating %><br>
									Prep time: <%= prepTime %> mins    Cook time: <%= cookTime %> mins
								</div></td></tr>
							<%
							  }
							%>
						</tbody>
			       </table>
		       </div>
		    </div>
		    <!-- Column for dropwdown and buttons -->
		    <div class="col-lg-4">
					<select id="mySelect">
					  <option></option>
					  <option value="favorites.jsp">Favorites</option>
					  <option value="toExplore.jsp">To Explore</option>
					  <option value="doNotShow.jsp">Do Not Show</option>
					</select><br><br>
		
				<button type="button" onclick="manageList()">Manage List</button><br><br>
				<button onclick="returnToResults()">Return to Results Page</button><br><br>
				<button onclick="returnToSearch()">Return to Search Page</button><br>
			</div>
		  </div>
		  <!-- Row for the edit button -->
		  <div class="row">
		  	<input type="button" value="Edit" class="styled-button-2" id="edit">
			<input type="button" value="Delete" class="styled-button-2" id="deleteButton">
		  
		  </div>
		</div>
	
		<script>		 
			function returnToSearch() {
				window.location.href = 'searchPage.html';
			}
			function returnToResults() {
				window.location.href = 'resultsPage.jsp';
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
		<script>
			var edit = document.getElementById("edit");
			var delete = document.getElementById("deleteButton");
	
			edit.onclick = function() {
			    deleteButton.style.visibility = "visible";
	
			}
		</script>
	
	</body>
</html>