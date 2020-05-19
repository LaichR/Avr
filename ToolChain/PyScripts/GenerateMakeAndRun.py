import os

import CheckoutGitRepo

CheckoutGitRepo.GenerateBatchFile(os.environ['ToolsRoot'], os.environ['ProjectRoot'] )
