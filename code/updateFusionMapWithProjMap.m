function fusion_map = updateFusionMapWithProjMap(fusion_map, updated_map, h, w, proj_flag)

    %==== TODO: Merge the updated map with the remaining part of the old fusion map ====

    % Compute the remaining index of the fusion map from proj_flag
    remain_flag = ~proj_flag;
    
    % Compute the remaining part of the old fusion map with remain_flag
    remain_flag_3 = repmat(remain_flag,1,3);
    remain_points = reshape(fusion_map.pointcloud.Location(remain_flag_3),[],3);
    remain_colors = reshape(fusion_map.pointcloud.Color(remain_flag_3),[],3);
    remain_normals = reshape(fusion_map.normals(remain_flag_3),[],3);
    remain_ccounts = fusion_map.ccounts(remain_flag);
    remain_times = fusion_map.times(remain_flag);
    
    % Reshape the updated map ((h*w)*3 for points, colors, normals and (h*w)*1 for ccounts, times)
    updated_points = reshape(updated_map.points, (h*w),3);
    updated_colors = reshape(updated_map.colors, (h*w),3);
    updated_normals = reshape(updated_map.normals, (h*w),3);
    updated_ccounts = reshape(updated_map.ccounts, (h*w),1);
    updated_times = reshape(updated_map.times, (h*w),1);
    
    % Merge the updated map with the remaining fusion map
    map_points = cat(1, remain_points, updated_points);
    map_colors = cat(1, remain_colors, updated_colors);
    map_normals = cat(1, remain_normals, updated_normals);
    map_ccounts = cat(1, remain_ccounts, updated_ccounts);
    map_times = cat(1, remain_times, updated_times);
    
    %==== Output the final point-based fusion map in a struct ====
    map_pointcloud = pointCloud(map_points, 'Color', map_colors);
    fusion_map = struct('pointcloud', map_pointcloud, 'normals', map_normals, 'ccounts', map_ccounts, 'times', map_times);
      
end
   