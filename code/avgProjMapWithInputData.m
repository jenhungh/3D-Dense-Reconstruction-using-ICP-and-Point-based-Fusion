function updated_map = avgProjMapWithInputData(proj_map, input_data, alpha, h, w, is_use, t)

    %==== Set variables ====
    input_points = input_data.pointcloud.Location;
    input_colors = input_data.pointcloud.Color;
    input_normals = input_data.normals;
    proj_points = proj_map.points;
    proj_colors = proj_map.colors;
    proj_normals = proj_map.normals;
    proj_ccounts = proj_map.ccounts;
    proj_times = proj_map.times;

    %==== TODO: Update all the terms in the projected map using the input data ====
    %==== (Hint: apply is_use[] as a mask in vectorization) ====
    
    % Initilaize the updated map with projected map (size: (h*w)*3 or (h*w)*1)
    updated_points = reshape(proj_points, (h*w), 3);   updated_colors = reshape(proj_colors, (h*w), 3);   updated_normals = reshape(proj_normals, (h*w), 3);
    updated_ccounts = reshape(proj_ccounts, (h*w), 1);   updated_times = reshape(proj_times, (h*w), 1);
    
    % Reshape is_use as a mask in vectorization
    is_use = reshape(is_use, (h*w), 1);
    is_use_3 = repmat(is_use,1,3);
    % Discard the unused maps (updated map, input data, alpha) by using is_use
    % updated maps
    used_points = reshape(updated_points(is_use_3),[],3);   used_normals = reshape(updated_normals(is_use_3),[],3);
    used_ccounts = updated_ccounts(is_use);
    % input data
    used_input_points = reshape(input_points(is_use_3),[],3);   used_input_colors = reshape(input_colors(is_use_3),[],3);
    used_input_normals = reshape(input_normals(is_use_3),[],3);
    % alpha
    reshaped_alpha = reshape(alpha, (h*w), 1);   used_alpha = reshaped_alpha(is_use);
    
    % Based on Paper[1] Sec.4.2, update the updated map by equation (1) and (2) (point averaging with sensor uncertainty)
    ave_points = (used_ccounts.*used_points + used_alpha.*used_input_points) ./ (used_ccounts + used_alpha);
    ave_normals = (used_ccounts.*used_normals + used_alpha.*used_input_normals) ./ (used_ccounts + used_alpha);
    updated_points(is_use_3) = reshape(ave_points,[],1);
    updated_normals(is_use_3) = reshape(ave_normals,[],1);
    updated_colors(is_use_3) = used_input_colors;
    updated_ccounts(is_use) = used_ccounts + used_alpha;
    updated_times(is_use) = t;
    
    % Reshape the updated map into the correct sizes
    % h*w*3 (points, colors, normals) and h*w*1 (ccounts, times)
    updated_points = reshape(updated_points, h,w,3);     updated_colors = reshape(updated_colors, h,w,3);   updated_normals = reshape(updated_normals, h,w,3);
    updated_ccounts = reshape(updated_ccounts, h,w,1);   updated_times = reshape(updated_times, h,w,1);
    
    %==== Output the updated projected map in a struct ====
    updated_map = struct('points', updated_points, 'colors', updated_colors, 'normals', updated_normals, 'ccounts', updated_ccounts, 'times', updated_times);
        
end