function [rel_err] = compute_rel_err(xtr,x)
for i=1:length(xtr)
    if norm(xtr(:))==0
       rel_err=norm( xtr(:) - x(:) );
    else
       rel_err = norm( xtr(:) - x(:) ) / norm( xtr(:) );
    end
end