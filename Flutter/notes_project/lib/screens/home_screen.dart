import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ghi Chú', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm ghi chú...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Danh sách ghi chú
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Demo 5 ghi chú
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.note, color: Colors.blueAccent),
                    title: Text(
                      'Ghi chú $index',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Nội dung ghi chú $index...'),
                    onTap: () {
                      // Chuyển đến trang chỉnh sửa ghi chú
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Floating Action Button mở rộng
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showBottomMenu(context);
        },
        icon: Icon(Icons.add),
        label: Text("Tạo mới"),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  // Hiển thị menu ở dưới cùng
  void _showBottomMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.note_add, color: Colors.green),
                title: Text('Thêm ghi chú'),
                onTap: () {
                  Navigator.pop(context);
                  // Chuyển đến trang thêm ghi chú
                },
              ),
              ListTile(
                leading: Icon(Icons.archive, color: Colors.orange),
                title: Text('Kho lưu trữ'),
                onTap: () {
                  Navigator.pop(context);
                  // Chuyển đến kho lưu trữ
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Kho đã xóa'),
                onTap: () {
                  Navigator.pop(context);
                  // Chuyển đến kho đã xóa
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
