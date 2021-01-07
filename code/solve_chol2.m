% SOLVE_CHOL2
% 16-833 Spring 2020 - *Stub* Provided
% Solves linear system using second Cholesky method
%
% Arguments: 
%     A     - A matrix from linear system that you generate yourself
%     b     - b vector from linear system that you generate yourself
%
% Returns:
%     x     - solution to the linear system, computed using the specified
%             version of the Cholesky decomposition
%     R     - R factor from the Cholesky decomposition
%
function [x, R] = solve_chol2(A, b)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Your code goes here %%%%%%%%%%%%%%%%%%%%%

% Solve the normal equation by Cholesky Factorization 
% But with fill-in-reducing ordering
% flag - whether A is symmetric positive definite or not (if flag==0, Cholesky Factorization is successful)
% p - permutation information (vector output form)
[R,flag,p] = chol(A.'*A, 'vector');

% Solve by forward substitution and backward substitution
if flag == 0
    % Forward Substitution with sorted (A.'*b)
    d = A.'*b;
    y = forward_sub(R.', d(p));

    % Backward Substitution
    x(p) = back_sub(R,y);
else
    % Cholesky Factorization fails
    disp(["Cholesky Factorization fails at ",num2str(flag),"th rows and columns."]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end