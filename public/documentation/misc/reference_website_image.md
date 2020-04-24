# Reusing the image of another website

Let's say you have a set of websites using the same source code and you want to 
speed up their deployments. You will have a reference website, let's say with site name *reference-image*. You will first deploy *reference-image* with:

    openode deploy

The other websites then need add a reference to this image:

    openode set-config REFERENCE_WEBSITE_IMAGE reference-image

Then when you *openode deploy* with this config, you will reuse the image from *reference-image* website and so the build will be more efficient.