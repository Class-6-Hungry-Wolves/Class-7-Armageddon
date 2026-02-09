# Cloudfront Stale HTML Incident 2/9/2026


Users were receiving a stale static/index.html after deployment while static assets were versioned and cached correctly. 
Repeated requests showed X-Cache: Hit from cloudfront and an increasing Age, confirming CloudFront was serving a cached HTML entrypoint. 

Because the HTML file is not versioned, we performed a targeted invalidation via CLI for /static/index.html (not /*) as a controlled break-glass operation. 

After invalidation completed, the next request returned Miss from cloudfront, Age reset, and the updated HTML was served. 
Versioning is preferred for static assets, but entrypoints sometimes require explicit invalidation.



### When to invalidate vs when to version

CloudFront invalidation is treated as a break-glass operation rather than part of normal deployments. When static assets are versioned (e.g., /static/app.<hash>.js), new deployments generate new filenames, so CloudFront treats them as new objects and no invalidation is required. This preserves cache hit ratio, reduces origin load, and maintains the performance and cost benefits of the CDN. 

Invalidation is reserved for cases where an unversioned object such as index.html must be refreshed immediately or during exceptional situations like security incidents or corrupted content. Wildcard invalidations (e.g., /*) are restricted because they dramatically increase origin load and reduce cache efficiency, expanding operational blast radius. 

A deployment strategy that requires routine invalidation is fundamentally flawed and should instead rely on proper asset versioning.
