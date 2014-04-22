try
    assert( ~verLessThan( 'layout', '1.0' ) )
catch
    % Tell user what is wrong
    hFigure = errordlg( 'GUI Layout Toolbox 1.0 or higher is required.', 'Error' );    
    return
end

matlab2048.app2048();
