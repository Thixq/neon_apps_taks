// ignore_for_file: avoid_catches_without_on_clauses, document_ignores

part of 'comment_bottom_sheet.dart';

mixin _CommentBottomSheetMixin on State<CommentBottomSheet> {
  late final TextEditingController controller;
  List<PopulatedCommentModel> localComments = [];

  @override
  void initState() {
    controller = TextEditingController();
    _fetchComments();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _fetchComments() async {
    if (widget.manager != null && widget.postId != null) {
      try {
        final fetched = await widget.manager!.fetchComments(widget.postId!);

        setState(() {
          localComments = fetched;
        });

        AppLogger.log(
          '✅ Loaded ${fetched.length} comments for post ${widget.postId}',
        );
      } catch (e, stackTrace) {
        AppLogger.error(
          e,
          stackTrace,
          reason: '❌ Failed to fetch comments for post ${widget.postId}',
        );

        // Hata durumunda boş listeye fallback yapabilirsin
        setState(() {
          localComments = [];
        });
      }
    } else {
      AppLogger.log('⚠️ No manager or postId provided, skipping fetchComments');
    }
  }

  void _addComment(String value) {
    if (value.trim().isEmpty) return;

    try {
      if (widget.manager != null && widget.postId != null) {
        final newComment = PopulatedCommentModel(
          id: '${DateTime.now().millisecondsSinceEpoch}',
          userId: widget.profile?.id,
          profile: widget.profile,
          comment: value,
          createdAt: DateTime.now(),
        );

        AppLogger.log(
          '📝 User ${widget.profile?.id} is adding a comment to post ${widget.postId}',
        );

        widget.manager!.addComment(postId: widget.postId!, comment: newComment);

        setState(() {
          localComments.insert(0, newComment);
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        e,
        stackTrace,
        reason: '❌ Failed to add comment from UI for post ${widget.postId}',
      );
    } finally {
      controller.clear();
    }
  }
}
