import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nabiba_app/Models/ReviewModel.dart';

class ReviewsServices{

  Future<String> addUserReviews(ReviewModel reviewModel) async{

    var data={
      "product_id":reviewModel.product_id,
      "username":reviewModel.userName,
      "userEmail":reviewModel.userEmail,
      "userReview":reviewModel.userReview,
      "userGivenRating":reviewModel.userGivenRating,
      "reviewDate":Timestamp.now()
    };
    CollectionReference usersReview = FirebaseFirestore.instance.collection('userReview');
    usersReview.add(data);
    return  "Your Review saved Successfully";


  }

  Future<List<ReviewModel>> getProductReviews(dynamic product_id) async{
    List<ReviewModel> reviewList=[];
    FirebaseFirestore.instance.collection('userReview').get().then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
    print(doc["product_id"]);
    if(product_id==doc['product_id']){
      ReviewModel rvmodel=
      ReviewModel(product_id: doc['product_id'],
          reviewDate: doc['reviewDate'],userEmail: doc['userEmail'],userGivenRating:
          doc['userGivenRating'],userName: doc['username'],userReview: doc['userReview']);
      reviewList.add(rvmodel);
    }

    })

    });

return   reviewList;
  }



}