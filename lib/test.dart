
class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController _shakeAnimationController;
  bool _isDeleteMode = false;
  List<Sppd> filteredSppdList = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _shakeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    _shakeAnimationController.dispose();
    super.dispose();
  }

  Future<bool> _showConfirmationDialog(BuildContext context, int sppdIndex) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete SPPD $sppdIndex?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return ;
  }
}