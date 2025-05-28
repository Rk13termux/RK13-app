import 'package:flutter/material.dart';

class RepoModel {
  final String name;
  final String description;
  final String scriptFile;
  final String readmeAsset;
  final String githubUrl;
  final String category;
  final String iconAsset;

  RepoModel({
    required this.name,
    required this.description,
    required this.scriptFile,
    required this.readmeAsset,
    required this.githubUrl,
    required this.category,
    required this.iconAsset,
  });
}