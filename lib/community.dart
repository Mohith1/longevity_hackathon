// lib/community.dart

import 'package:flutter/material.dart';
import 'home.dart';

/// Community screen displaying groups for users to join and interact
class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Community'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Groups You Might Like',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: const [
                    GroupTile(
                      name: 'Flex Enthusiasts',
                      memberCount: 124,
                      assetPath: 'assets/images/group_flex.png',
                    ),
                    GroupTile(
                      name: 'Yoga Lovers 30-40',
                      memberCount: 87,
                      assetPath: 'assets/images/group_yoga.png',
                    ),
                    GroupTile(
                      name: 'Senior Mobility',
                      memberCount: 54,
                      assetPath: 'assets/images/group_senior.png',
                    ),
                    GroupTile(
                      name: 'Weekend Warriors',
                      memberCount: 203,
                      assetPath: 'assets/images/group_weekend.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget representing a single group entry with text above the image and join button
class GroupTile extends StatelessWidget {
  final String name;
  final int memberCount;
  final String assetPath;

  const GroupTile({
    Key? key,
    required this.name,
    required this.memberCount,
    required this.assetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              assetPath,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$memberCount members',
                  style: const TextStyle(color: Colors.grey),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: implement join or interact action
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Join'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

