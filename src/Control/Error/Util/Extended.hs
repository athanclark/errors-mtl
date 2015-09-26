module Control.Error.Util.Extended
  ( noteError
  , noteErrorT
  , guardError
  ) where

import Data.Maybe (fromMaybe)
import Control.Monad.Except as X
import Control.Error as X


-- | Throws the error when Nothing
noteError :: ( MonadError e m
             ) => e -> Maybe a -> m a
noteError e mx = fromMaybe (throwError e) $ pure <$> mx

noteErrorT :: ( MonadError e m
              ) => e -> MaybeT m a -> m a
noteErrorT e mx = do
  mx' <- runMaybeT mx
  noteError e mx'

-- | Throws the error when False
guardError :: ( MonadError e m
              ) => e -> Bool -> m ()
guardError e b = if b then return () else throwError e


