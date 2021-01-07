function is_use = isUsableInputPoints(is_close, is_similar, is_first)

    %==== TODO: Compute is_use, indicating input points to add to fusion map based on input booleans ====
    % The input point is useful if it is close enough (smaller than dist2_th) and its normal is similar enough (bigger than dot_th)
    % or it is a newly observed point
    is_use = (is_close & is_similar) | is_first;
    
end