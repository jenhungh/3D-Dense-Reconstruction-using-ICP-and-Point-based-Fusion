function [proj_map, proj_flag] = projMapToFrame(fusion_map, h, w, tform, cam_param)
    
    %==== Set parameters ====
    fx = cam_param(1);
    fy = cam_param(2);
    cx = cam_param(3);
    cy = cam_param(4);

    %==== TODO: Project all terms in the fusion map based on other input parameters ====
    %==== (Hint 1: Only project the points in front of the camera) ====
    %==== (Hint 2: Calculate all the projected indices together and use them in vectorization) ====
    %==== (Hint 3: Discard the indices that exceed the frame boundaries) ====
    
    % Transform the fusion map into camaera frame(cf)
    tform_invert = invert(tform);
    points_in_cf = pctransform(fusion_map.pointcloud, tform_invert);
    
    % Check if the points are in front of the camera (z coordinate > 0)
    index_in_front = (points_in_cf.Location(:,3)>0);
    % Compute the valid points with valid index
    index_in_front_3 = repmat(index_in_front,1,3);
    valid_points = points_in_cf.Location .* index_in_front_3;
    
    % Compute the Camera Intrinsic Matrix
    K = [fx 0 cx; 0 fy cy; 0 0 1];
    % Discard the points that are not in front of the camera
    points_in_front = reshape(valid_points(index_in_front_3),[],3);
    % Project the points in front of the camera onto the image plane (but NOT supersampling)
    projected_points = (K * points_in_front.').';
    projected_points = projected_points ./ projected_points(:,3);
    % Update the valid point (into projected valid points)
    valid_points(index_in_front_3) = reshape(projected_points,[],1);
    
    % Check if the projected valid points exceed the frame boundaries (0 < x < h, 0 < y < w)
    index_in_boundaries = valid_points(:,1) > 0 & valid_points(:,1) < h & valid_points(:,2) > 0 & valid_points(:,2) < w;
    
    % Update the valid points index (proj_flag)
    proj_flag = and(index_in_front, index_in_boundaries);
    
    % Compute and Organize the elements of the projected map
    % Initialize the projected map with size M*3 (points, colors, normals) and M*1 (ccounts, times)
    proj_points = zeros((h*w),3);    proj_colors = zeros((h*w),3);    proj_normals = zeros((h*w),3);
    proj_ccounts = zeros((h*w),1);   proj_times = zeros((h*w),1);
    
    % Discard the points that are behind the camera and outside the frame boundaries by using valid point index (proj_flag)
    proj_flag_3 = repmat(proj_flag,1,3);
    available_points = reshape(fusion_map.pointcloud.Location(proj_flag_3),[],3);   % (h*w)*3
    available_colors = reshape(fusion_map.pointcloud.Color(proj_flag_3),[],3);      % (h*w)*3
    available_normals = reshape(fusion_map.normals(proj_flag_3),[],3);              % (h*w)*3
    available_ccounts = fusion_map.ccounts(proj_flag);                              % (h*w)*1
    available_times = fusion_map.times(proj_flag);                                  % (h*w)*1
    
    % Compute the available index
    valid_points = ceil(valid_points);
    available_index = reshape(valid_points(proj_flag_3),[],3);
    
    % Update the projected map with the available index and data
    updated_index = 1 + available_index(:,1)*h + available_index(:,2);
    proj_points(updated_index,:) = available_points;
    proj_colors(updated_index,:) = available_colors;
    proj_normals(updated_index,:) = available_normals;
    proj_ccounts(updated_index,:) = available_ccounts;
    proj_times(updated_index,:) = available_times;
    
    % Reshape the projected map into the correct sizes
    % h*w*3 (points, colors, normals) and h*w*1 (ccounts, times)
    proj_points = reshape(proj_points, h,w,3);     proj_colors = reshape(proj_colors, h,w,3);   proj_normals = reshape(proj_normals, h,w,3);
    proj_ccounts = reshape(proj_ccounts, h,w,1);   proj_times = reshape(proj_times, h,w,1);
    
    %==== Output the projected map in a struct ====
    %==== (Notice: proj_points[], proj_colors[], and proj_normals[] are all 3D matrices with size h*w*3) ====
    %==== (Notice: proj_ccounts[] and proj_times[] are both 2D matrices with size h*w) ====
    proj_map = struct('points', proj_points, 'colors', proj_colors, 'normals', proj_normals, 'ccounts', proj_ccounts, 'times', proj_times);
        
end
