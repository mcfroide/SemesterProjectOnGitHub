function E=FrobeniusRelativeError(OriginalFrame, RecoveredFrame)

E=norm(OriginalFrame-RecoveredFrame,'fro')/norm(OriginalFrame,'fro');

return