class Category {
  String response;
  List<Categorylist> categorylist;

  Category({this.response, this.categorylist});

  Category.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    if (json['categorylist'] != null) {
      categorylist = new List<Categorylist>();
      json['categorylist'].forEach((v) {
        categorylist.add(new Categorylist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    if (this.categorylist != null) {
      data['categorylist'] = this.categorylist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categorylist {
  int categoryId;
  String categoryTitle;
  List<CategoryPost> categoryPost;

  Categorylist({this.categoryId, this.categoryTitle, this.categoryPost});

  Categorylist.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryTitle = json['categoryTitle'];
    if (json['categoryPost'] != null) {
      categoryPost = new List<CategoryPost>();
      json['categoryPost'].forEach((v) {
        categoryPost.add(new CategoryPost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryTitle'] = this.categoryTitle;
    if (this.categoryPost != null) {
      data['categoryPost'] = this.categoryPost.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryPost {
  int postId;
  String postTitle;
  String reference;
  List<PostContent> postContent;

  CategoryPost({this.postId, this.postTitle, this.reference, this.postContent});

  CategoryPost.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    postTitle = json['postTitle'];
    reference = json['reference'];
    if (json['postContent'] != null) {
      postContent = new List<PostContent>();
      json['postContent'].forEach((v) {
        postContent.add(new PostContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['postTitle'] = this.postTitle;
    data['reference'] = this.reference;
    if (this.postContent != null) {
      data['postContent'] = this.postContent.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostContent {
  int contentId;
  String author;
  String content;
  String note;
  String explanation;

  PostContent(
      {this.contentId, this.author, this.content, this.note, this.explanation});

  PostContent.fromJson(Map<String, dynamic> json) {
    contentId = json['contentId'];
    author = json['author'];
    content = json['content'];
    note = json['note'];
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentId'] = this.contentId;
    data['author'] = this.author;
    data['content'] = this.content;
    data['note'] = this.note;
    data['explanation'] = this.explanation;
    return data;
  }
}
