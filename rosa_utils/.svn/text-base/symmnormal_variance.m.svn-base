function variance = symmnormal_variance( symm_nor, normals )

alphas = sum( normals.*repmat( symm_nor, size(normals,1), 1 ), 2 );
variance = var(alphas);
           