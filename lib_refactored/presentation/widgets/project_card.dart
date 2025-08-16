import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../domain/models/project/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and actions
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name ?? 'Untitled Project',
                          style: AppTextStyles.h6.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        _buildStatusChip(),
                      ],
                    ),
                  ),
                  if (onEdit != null || onDelete != null)
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            onEdit?.call();
                            break;
                          case 'delete':
                            onDelete?.call();
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        if (onEdit != null)
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 16),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                        if (onDelete != null)
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 16, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Delete', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Description
              if (project.description != null && project.description!.isNotEmpty)
                Text(
                  project.description!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              
              const SizedBox(height: 12),
              
              // Progress bar
              _buildProgressBar(),
              
              const SizedBox(height: 12),
              
              // Footer with dates and stats
              Row(
                children: [
                  // Dates
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (project.startDate != null)
                          _buildDateInfo(
                            'Start',
                            project.startDate!,
                            Icons.calendar_today,
                          ),
                        if (project.endDate != null) ...[
                          const SizedBox(height: 4),
                          _buildDateInfo(
                            'End',
                            project.endDate!,
                            Icons.event,
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Stats
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildStatItem(
                        'Tasks',
                        '${project.completedTasks ?? 0}/${project.totalTasks ?? 0}',
                        Icons.task,
                      ),
                      const SizedBox(height: 4),
                      _buildStatItem(
                        'Teams',
                        '${project.teams?.length ?? 0}',
                        Icons.group,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    Color chipColor;
    Color textColor;
    
    switch (project.status) {
      case 'active':
        chipColor = AppColors.success.withOpacity(0.1);
        textColor = AppColors.success;
        break;
      case 'completed':
        chipColor = AppColors.info.withOpacity(0.1);
        textColor = AppColors.info;
        break;
      case 'on_hold':
        chipColor = AppColors.warning.withOpacity(0.1);
        textColor = AppColors.warning;
        break;
      case 'cancelled':
        chipColor = AppColors.error.withOpacity(0.1);
        textColor = AppColors.error;
        break;
      default:
        chipColor = AppColors.textMuted.withOpacity(0.1);
        textColor = AppColors.textMuted;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        project.statusDisplay,
        style: AppTextStyles.caption.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = project.progressPercentage;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '${progress.toStringAsFixed(1)}%',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress / 100,
          backgroundColor: AppColors.border,
          valueColor: AlwaysStoppedAnimation<Color>(
            progress >= 100 ? AppColors.success : AppColors.primary,
          ),
          minHeight: 6,
        ),
      ],
    );
  }

  Widget _buildDateInfo(String label, DateTime date, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12,
          color: AppColors.textMuted,
        ),
        const SizedBox(width: 4),
        Text(
          '$label: ${_formatDate(date)}',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 12,
          color: AppColors.textMuted,
        ),
        const SizedBox(width: 4),
        Text(
          '$label: $value',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference == -1) {
      return 'Tomorrow';
    } else if (difference > 0) {
      return '${difference}d ago';
    } else {
      return 'In ${difference.abs()}d';
    }
  }
}