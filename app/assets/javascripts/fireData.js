function firebaseSignUpUser(){
	firebase.auth().createUserWithEmailAndPassword(document.getElementById("newUserForm").children[5].value, document.getElementById("newUserForm").children[7].value).catch(function(error){
		var errorCode = error.code;
		var errorMessage = error.message;
		console.log(errorCode);
		console.log(errorMessage);
	});
}


function firebaseLoginUser(){
	firebase.auth().signInWithEmailAndPassword(document.getElementById("newUserForm").children[5].value, document.getElementById("newUserForm").children[7].value).catch(function(error){
		var errorCode = error.code;
		var errorMessage = error.message;
		console.log(errorCode);
		console.log(errorMessage);
	});
}



