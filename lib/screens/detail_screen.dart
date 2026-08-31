import 'package:iguiron_mobprog/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/comment.dart';
import '../models/user.dart';
import '../services/comment_service.dart';
import '../widgets/custom_font.dart';

class DetailScreen extends StatefulWidget {
  final String userName;
  final String userImage;
  final String postContent;
  final String date;
  final int numOfLikes;
  final String contentImage;
  final int? postId;
  final User? currentUser;

  const DetailScreen({
    super.key,
    required this.userName,
    this.userImage = '',
    required this.postContent,
    this.numOfLikes = 0,
    required this.date,
    this.contentImage = '',
    this.postId,
    this.currentUser,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late int currentLikes;
  bool isLiked = false;

  final CommentService _commentService = CommentService();
  final TextEditingController _commentController = TextEditingController();

  List<Comment> _comments = [];
  final Map<int, int> _commentLikeOverrides = {};
  final Set<int> _likedCommentIds = {};
  bool _loadingComments = true;
  String? _commentsError;
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    currentLikes = widget.numOfLikes;
    if (widget.postId != null) {
      _loadComments();
    } else {
      _loadingComments = false;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    setState(() {
      _loadingComments = true;
      _commentsError = null;
    });

    try {
      final comments = await _commentService.getCommentsByPost(widget.postId!);
      setState(() {
        _comments = comments;
        _loadingComments = false;
      });
    } catch (e) {
      setState(() {
        _commentsError = 'Failed to load comments';
        _loadingComments = false;
      });
    }
  }

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        currentLikes--;
        isLiked = false;
      } else {
        currentLikes++;
        isLiked = true;
      }
    });
  }

  void _toggleCommentLike(Comment comment) {
    setState(() {
      final currentCount = _commentLikeOverrides[comment.id] ?? comment.likes;
      if (_likedCommentIds.contains(comment.id)) {
        _likedCommentIds.remove(comment.id);
        _commentLikeOverrides[comment.id] = currentCount - 1;
      } else {
        _likedCommentIds.add(comment.id);
        _commentLikeOverrides[comment.id] = currentCount + 1;
      }
    });
  }

  Future<void> _submitComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty || widget.postId == null || widget.currentUser == null) {
      return;
    }

    setState(() => _isPosting = true);

    try {
      final newComment = await _commentService.addComment(
        widget.postId!,
        text,
        widget.currentUser!.id,
      );
      setState(() {
        _comments.insert(0, newComment);
        _commentController.clear();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to post comment')),
      );
    } finally {
      if (mounted) setState(() => _isPosting = false);
    }
  }

  ImageProvider? _avatarProvider(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return null;
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return CachedNetworkImageProvider(imagePath);
    }
    return AssetImage(imagePath);
  }

  Widget _buildCommentsSection() {
    final canComment = widget.postId != null && widget.currentUser != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
          child: CustomFont(
            text: 'Comments',
            fontSize: ScreenUtil().setSp(16),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        if (widget.postId == null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: CustomFont(
              text: 'Comments are not available for this post.',
              fontSize: ScreenUtil().setSp(13),
              color: Colors.grey,
            ),
          )
        else if (_loadingComments)
          const Center(child: CircularProgressIndicator())
        else if (_commentsError != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: CustomFont(
              text: _commentsError!,
              fontSize: ScreenUtil().setSp(13),
              color: Colors.red,
            ),
          )
        else if (_comments.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: CustomFont(
              text: 'No comments yet. Be the first to comment!',
              fontSize: ScreenUtil().setSp(13),
              color: Colors.grey,
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _comments.length,
            itemBuilder: (context, index) {
              final comment = _comments[index];
              final isCommentLiked = _likedCommentIds.contains(comment.id);
              final likeCount = _commentLikeOverrides[comment.id] ?? comment.likes;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setHeight(6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: ScreenUtil().setSp(16),
                      child: const Icon(Icons.person, size: 18),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(ScreenUtil().setSp(10)),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomFont(
                                  text: comment.user.fullName,
                                  fontSize: ScreenUtil().setSp(13),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomFont(
                                  text: comment.body,
                                  fontSize: ScreenUtil().setSp(13),
                                  color: Colors.black87,
                                ),
                              ],
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => _toggleCommentLike(comment),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: Icon(
                              Icons.thumb_up,
                              size: 14,
                              color: isCommentLiked ? Colors.blue : Colors.grey,
                            ),
                            label: CustomFont(
                              text: likeCount > 0 ? '$likeCount' : 'Like',
                              fontSize: ScreenUtil().setSp(11),
                              color: isCommentLiked ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
          child: Row(
            children: [
              CircleAvatar(
                radius: ScreenUtil().setSp(16),
                backgroundImage: _avatarProvider(widget.currentUser?.image),
                child: widget.currentUser == null
                    ? const Icon(Icons.person, size: 18)
                    : null,
              ),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Expanded(
                child: TextField(
                  controller: _commentController,
                  enabled: canComment && !_isPosting,
                  decoration: InputDecoration(
                    hintText: canComment
                        ? 'Write a comment...'
                        : 'Sign in to comment',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15),
                      vertical: ScreenUtil().setHeight(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: _isPosting
                    ? SizedBox(
                        height: ScreenUtil().setHeight(18),
                        width: ScreenUtil().setWidth(18),
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send, color: FB_DARK_PRIMARY),
                onPressed: canComment && !_isPosting ? _submitComment : null,
              ),
            ],
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(20)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomFont(
          text: widget.userName,
          fontSize: ScreenUtil().setSp(20),
          color: Colors.black,
        ),
      ),
      body: Container(
        color: Colors.white,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              (widget.contentImage == '')
                  ? SizedBox(height: ScreenUtil().setHeight(0))
                  : Image.asset(widget.contentImage, fit: BoxFit.cover),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (widget.userImage == '')
                        ? const Icon(Icons.person)
                        : CircleAvatar(
                            radius: ScreenUtil().setSp(25),
                            backgroundImage: _avatarProvider(widget.userImage),
                          ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFont(
                          text: widget.userName,
                          fontSize: ScreenUtil().setSp(20),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomFont(
                              text: widget.date,
                              fontSize: ScreenUtil().setSp(15),
                              color: Colors.grey,
                            ),
                            SizedBox(width: ScreenUtil().setWidth(3)),
                            Icon(
                              Icons.public,
                              color: Colors.grey,
                              size: ScreenUtil().setSp(18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.more_horiz),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(15)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                alignment: Alignment.centerLeft,
                child: CustomFont(
                  text: widget.postContent,
                  fontSize: ScreenUtil().setSp(18),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              const Divider(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: _toggleLike,
                      icon: Icon(
                        Icons.thumb_up,
                        color: isLiked ? Colors.blue : FB_DARK_PRIMARY,
                      ),
                      label: CustomFont(
                        text: (currentLikes == 0)
                            ? 'Like'
                            : currentLikes.toString(),
                        fontSize: ScreenUtil().setSp(12),
                        color: isLiked ? Colors.blue : FB_DARK_PRIMARY,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.comment, color: FB_DARK_PRIMARY),
                      label: CustomFont(
                        text: 'Comment',
                        fontSize: ScreenUtil().setSp(12),
                        color: FB_DARK_PRIMARY,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        color: FB_DARK_PRIMARY,
                      ),
                      label: CustomFont(
                        text: 'Share',
                        fontSize: ScreenUtil().setSp(12),
                        color: FB_DARK_PRIMARY,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(height: ScreenUtil().setHeight(10)),
              _buildCommentsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
