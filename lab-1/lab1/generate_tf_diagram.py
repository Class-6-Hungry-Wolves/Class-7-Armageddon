#!/usr/bin/env python3
"""
Terraform Infrastructure Diagram Generator
Generates a clean, modular, Visio-compatible SVG diagram from Terraform configuration.
"""

import re
import subprocess
import xml.etree.ElementTree as ET
from collections import defaultdict
from dataclasses import dataclass
from typing import Dict, List, Set, Tuple

# Color scheme for AWS resource types (AWS official colors where applicable)
RESOURCE_COLORS = {
    # Networking - Orange
    'aws_vpc': {'fill': '#FF9900', 'stroke': '#CC7A00', 'category': 'Networking'},
    'aws_subnet': {'fill': '#FFB84D', 'stroke': '#CC7A00', 'category': 'Networking'},
    'aws_internet_gateway': {'fill': '#FF9900', 'stroke': '#CC7A00', 'category': 'Networking'},
    'aws_nat_gateway': {'fill': '#FFB84D', 'stroke': '#CC7A00', 'category': 'Networking'},
    'aws_route_table': {'fill': '#FFCC80', 'stroke': '#CC7A00', 'category': 'Networking'},
    'aws_route_table_association': {'fill': '#FFE0B3', 'stroke': '#CC7A00', 'category': 'Networking'},
    'aws_route': {'fill': '#FFE0B3', 'stroke': '#CC7A00', 'category': 'Networking'},
    'aws_eip': {'fill': '#FF9900', 'stroke': '#CC7A00', 'category': 'Networking'},
    'aws_vpc_endpoint': {'fill': '#FFB84D', 'stroke': '#CC7A00', 'category': 'Networking'},

    # Security - Red
    'aws_security_group': {'fill': '#DD3333', 'stroke': '#AA2222', 'category': 'Security'},
    'aws_security_group_rule': {'fill': '#FF6666', 'stroke': '#AA2222', 'category': 'Security'},
    'aws_wafv2_web_acl': {'fill': '#DD3333', 'stroke': '#AA2222', 'category': 'Security'},
    'aws_wafv2_web_acl_association': {'fill': '#FF6666', 'stroke': '#AA2222', 'category': 'Security'},
    'aws_wafv2_web_acl_logging_configuration': {'fill': '#FF9999', 'stroke': '#AA2222', 'category': 'Security'},

    # Compute - Green
    'aws_instance': {'fill': '#3F8624', 'stroke': '#2D6118', 'category': 'Compute'},
    'aws_lb': {'fill': '#8CC63F', 'stroke': '#6B9930', 'category': 'Compute'},
    'aws_lb_listener': {'fill': '#A8D86B', 'stroke': '#6B9930', 'category': 'Compute'},
    'aws_lb_listener_rule': {'fill': '#C4EA97', 'stroke': '#6B9930', 'category': 'Compute'},
    'aws_lb_target_group': {'fill': '#8CC63F', 'stroke': '#6B9930', 'category': 'Compute'},
    'aws_lb_target_group_attachment': {'fill': '#C4EA97', 'stroke': '#6B9930', 'category': 'Compute'},
    'aws_lambda_function': {'fill': '#FF9900', 'stroke': '#CC7A00', 'category': 'Compute'},
    'aws_lambda_permission': {'fill': '#FFB84D', 'stroke': '#CC7A00', 'category': 'Compute'},

    # Database - Blue
    'aws_db_instance': {'fill': '#3B48CC', 'stroke': '#2D3899', 'category': 'Database'},
    'aws_db_subnet_group': {'fill': '#6B7AE8', 'stroke': '#2D3899', 'category': 'Database'},

    # Storage - Green (S3)
    'aws_s3_bucket': {'fill': '#569A31', 'stroke': '#3D6E23', 'category': 'Storage'},
    'aws_s3_bucket_policy': {'fill': '#7AB648', 'stroke': '#3D6E23', 'category': 'Storage'},
    'aws_s3_bucket_versioning': {'fill': '#9DD35F', 'stroke': '#3D6E23', 'category': 'Storage'},
    'aws_s3_bucket_lifecycle_configuration': {'fill': '#9DD35F', 'stroke': '#3D6E23', 'category': 'Storage'},
    'aws_s3_bucket_server_side_encryption_configuration': {'fill': '#9DD35F', 'stroke': '#3D6E23', 'category': 'Storage'},
    'aws_s3_bucket_public_access_block': {'fill': '#9DD35F', 'stroke': '#3D6E23', 'category': 'Storage'},
    'aws_s3_bucket_ownership_controls': {'fill': '#9DD35F', 'stroke': '#3D6E23', 'category': 'Storage'},

    # CDN - Purple (CloudFront)
    'aws_cloudfront_distribution': {'fill': '#8C4FFF', 'stroke': '#6B3CC7', 'category': 'CDN'},
    'aws_cloudfront_cache_policy': {'fill': '#A77BFF', 'stroke': '#6B3CC7', 'category': 'CDN'},
    'aws_cloudfront_origin_request_policy': {'fill': '#C2A7FF', 'stroke': '#6B3CC7', 'category': 'CDN'},
    'aws_cloudfront_response_headers_policy': {'fill': '#C2A7FF', 'stroke': '#6B3CC7', 'category': 'CDN'},

    # DNS - Teal (Route53)
    'aws_route53_record': {'fill': '#007DAF', 'stroke': '#005A7F', 'category': 'DNS'},
    'aws_route53_zone': {'fill': '#00A3E0', 'stroke': '#005A7F', 'category': 'DNS'},
    'data.aws_route53_zone': {'fill': '#00A3E0', 'stroke': '#005A7F', 'category': 'DNS'},

    # Certificates - Gold
    'aws_acm_certificate': {'fill': '#D4AF37', 'stroke': '#A68929', 'category': 'Certificates'},
    'aws_acm_certificate_validation': {'fill': '#E8C547', 'stroke': '#A68929', 'category': 'Certificates'},

    # IAM - Pink/Red
    'aws_iam_role': {'fill': '#C41E3A', 'stroke': '#8E1629', 'category': 'IAM'},
    'aws_iam_policy': {'fill': '#E85A71', 'stroke': '#8E1629', 'category': 'IAM'},
    'aws_iam_role_policy': {'fill': '#F08896', 'stroke': '#8E1629', 'category': 'IAM'},
    'aws_iam_role_policy_attachment': {'fill': '#F5B3BC', 'stroke': '#8E1629', 'category': 'IAM'},
    'aws_iam_instance_profile': {'fill': '#C41E3A', 'stroke': '#8E1629', 'category': 'IAM'},

    # Monitoring - Cyan (CloudWatch)
    'aws_cloudwatch_log_group': {'fill': '#00CED1', 'stroke': '#009B9E', 'category': 'Monitoring'},
    'aws_cloudwatch_metric_alarm': {'fill': '#48D1CC', 'stroke': '#009B9E', 'category': 'Monitoring'},
    'aws_cloudwatch_dashboard': {'fill': '#7FFFD4', 'stroke': '#009B9E', 'category': 'Monitoring'},

    # Messaging - Magenta (SNS)
    'aws_sns_topic': {'fill': '#D946EF', 'stroke': '#A336B9', 'category': 'Messaging'},
    'aws_sns_topic_subscription': {'fill': '#E879F9', 'stroke': '#A336B9', 'category': 'Messaging'},

    # Secrets - Dark Blue
    'aws_secretsmanager_secret': {'fill': '#1E3A5F', 'stroke': '#142740', 'category': 'Secrets'},
    'aws_secretsmanager_secret_version': {'fill': '#2D5A8C', 'stroke': '#142740', 'category': 'Secrets'},
    'aws_secretsmanager_secret_rotation': {'fill': '#3D7ABF', 'stroke': '#142740', 'category': 'Secrets'},

    # SSM - Light Blue
    'aws_ssm_parameter': {'fill': '#4AA8D8', 'stroke': '#357FA3', 'category': 'SSM'},

    # Serverless App Repo
    'aws_serverlessapplicationrepository_cloudformation_stack': {'fill': '#FF9900', 'stroke': '#CC7A00', 'category': 'Serverless'},

    # Random/Utility
    'random_password': {'fill': '#6B7280', 'stroke': '#4B5563', 'category': 'Utility'},
    'random_string': {'fill': '#6B7280', 'stroke': '#4B5563', 'category': 'Utility'},

    # Data sources
    'data.aws_caller_identity': {'fill': '#9CA3AF', 'stroke': '#6B7280', 'category': 'Data'},
    'data.aws_region': {'fill': '#9CA3AF', 'stroke': '#6B7280', 'category': 'Data'},
    'data.aws_availability_zones': {'fill': '#9CA3AF', 'stroke': '#6B7280', 'category': 'Data'},
    'data.aws_ec2_managed_prefix_list': {'fill': '#9CA3AF', 'stroke': '#6B7280', 'category': 'Data'},
    'data.aws_secretsmanager_secret': {'fill': '#9CA3AF', 'stroke': '#6B7280', 'category': 'Data'},
}

DEFAULT_COLOR = {'fill': '#E5E7EB', 'stroke': '#9CA3AF', 'category': 'Other'}

# Category box colors
CATEGORY_COLORS = {
    'Networking': '#FFF3E0',
    'Security': '#FFEBEE',
    'Compute': '#E8F5E9',
    'Database': '#E3F2FD',
    'Storage': '#E8F5E9',
    'CDN': '#F3E5F5',
    'DNS': '#E0F7FA',
    'Certificates': '#FFF8E1',
    'IAM': '#FCE4EC',
    'Monitoring': '#E0F7FA',
    'Messaging': '#F3E5F5',
    'Secrets': '#E8EAF6',
    'SSM': '#E1F5FE',
    'Serverless': '#FFF3E0',
    'Utility': '#F5F5F5',
    'Data': '#FAFAFA',
    'Other': '#FFFFFF',
}

@dataclass
class Resource:
    """Represents a Terraform resource"""
    full_name: str
    resource_type: str
    resource_name: str
    category: str
    color: dict

@dataclass
class Edge:
    """Represents a dependency edge"""
    source: str
    target: str

def get_resource_color(resource_type: str) -> dict:
    """Get color configuration for a resource type"""
    # Check for exact match
    if resource_type in RESOURCE_COLORS:
        return RESOURCE_COLORS[resource_type]

    # Check for prefix match (e.g., aws_s3_bucket matches aws_s3_bucket_*)
    for key, value in RESOURCE_COLORS.items():
        if resource_type.startswith(key):
            return value

    return DEFAULT_COLOR

def parse_terraform_graph() -> Tuple[Dict[str, Resource], List[Edge]]:
    """Parse terraform graph output"""
    try:
        result = subprocess.run(['terraform', 'graph'], capture_output=True, text=True)
        graph_output = result.stdout
    except Exception as e:
        print(f"Error running terraform graph: {e}")
        return {}, []

    resources = {}
    edges = []

    # Parse nodes
    node_pattern = r'\[root\]\s+([\w.]+)\.([\w_]+)\s+\(expand\)'
    for match in re.finditer(node_pattern, graph_output):
        resource_type = match.group(1)
        resource_name = match.group(2)
        full_name = f"{resource_type}.{resource_name}"

        color = get_resource_color(resource_type)
        category = color.get('category', 'Other')

        resources[full_name] = Resource(
            full_name=full_name,
            resource_type=resource_type,
            resource_name=resource_name,
            category=category,
            color=color
        )

    # Parse edges
    edge_pattern = r'\"\[root\]\s+([\w.]+)\.([\w_]+)\s+\(expand\)\"\s+->\s+\"\[root\]\s+([\w.]+)\.([\w_]+)\s+\(expand\)\"'
    for match in re.finditer(edge_pattern, graph_output):
        source = f"{match.group(1)}.{match.group(2)}"
        target = f"{match.group(3)}.{match.group(4)}"
        if source in resources and target in resources:
            edges.append(Edge(source=source, target=target))

    return resources, edges

def detect_cycles(resources: Dict[str, Resource], edges: List[Edge]) -> List[List[str]]:
    """Detect cycles in the dependency graph using DFS"""
    graph = defaultdict(list)
    for edge in edges:
        graph[edge.source].append(edge.target)

    cycles = []
    visited = set()
    rec_stack = set()

    def dfs(node: str, path: List[str]) -> None:
        visited.add(node)
        rec_stack.add(node)
        path.append(node)

        for neighbor in graph[node]:
            if neighbor not in visited:
                dfs(neighbor, path)
            elif neighbor in rec_stack:
                # Found a cycle
                cycle_start = path.index(neighbor)
                cycles.append(path[cycle_start:] + [neighbor])

        path.pop()
        rec_stack.remove(node)

    for node in resources:
        if node not in visited:
            dfs(node, [])

    return cycles

def create_svg_diagram(resources: Dict[str, Resource], edges: List[Edge], cycles: List[List[str]]) -> str:
    """Generate an SVG diagram"""

    # Group resources by category
    categories = defaultdict(list)
    for resource in resources.values():
        categories[resource.category].append(resource)

    # Sort categories for consistent layout
    category_order = ['CDN', 'DNS', 'Certificates', 'Security', 'Networking', 'Compute',
                      'Database', 'Storage', 'IAM', 'Monitoring', 'Messaging', 'Secrets',
                      'SSM', 'Serverless', 'Utility', 'Data', 'Other']

    sorted_categories = []
    for cat in category_order:
        if cat in categories:
            sorted_categories.append(cat)
    for cat in categories:
        if cat not in sorted_categories:
            sorted_categories.append(cat)

    # Calculate dimensions
    box_width = 280
    box_height = 36
    box_margin = 12
    category_padding = 30
    category_margin = 40
    legend_width = 200

    # Calculate category heights and positions
    category_positions = {}
    current_y = 80
    max_width = 0

    for category in sorted_categories:
        items = categories[category]
        num_cols = min(3, len(items))
        num_rows = (len(items) + num_cols - 1) // num_cols

        cat_height = category_padding * 2 + num_rows * (box_height + box_margin) + 40
        cat_width = category_padding * 2 + num_cols * (box_width + box_margin)

        category_positions[category] = {
            'x': 50,
            'y': current_y,
            'width': cat_width,
            'height': cat_height,
            'items': items
        }

        max_width = max(max_width, cat_width)
        current_y += cat_height + category_margin

    # SVG dimensions
    svg_width = max_width + 150 + legend_width
    svg_height = current_y + 100

    # Resources in cycles for highlighting
    cycle_resources = set()
    for cycle in cycles:
        cycle_resources.update(cycle)

    # Build SVG
    svg_parts = []

    # SVG header with styles
    svg_parts.append(f'''<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     width="{svg_width}" height="{svg_height}"
     viewBox="0 0 {svg_width} {svg_height}">

  <defs>
    <style>
      .title {{ font-family: Arial, sans-serif; font-size: 24px; font-weight: bold; fill: #1F2937; }}
      .subtitle {{ font-family: Arial, sans-serif; font-size: 14px; fill: #6B7280; }}
      .category-title {{ font-family: Arial, sans-serif; font-size: 16px; font-weight: bold; fill: #374151; }}
      .resource-text {{ font-family: Arial, sans-serif; font-size: 11px; fill: #FFFFFF; }}
      .resource-text-dark {{ font-family: Arial, sans-serif; font-size: 11px; fill: #1F2937; }}
      .legend-title {{ font-family: Arial, sans-serif; font-size: 14px; font-weight: bold; fill: #374151; }}
      .legend-text {{ font-family: Arial, sans-serif; font-size: 11px; fill: #4B5563; }}
      .cycle-warning {{ font-family: Arial, sans-serif; font-size: 12px; fill: #DC2626; font-weight: bold; }}
    </style>

    <!-- Drop shadow filter -->
    <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="2" dy="2" stdDeviation="3" flood-opacity="0.15"/>
    </filter>

    <!-- Cycle highlight filter -->
    <filter id="cycle-glow">
      <feGaussianBlur stdDeviation="3" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <!-- Background -->
  <rect width="100%" height="100%" fill="#F9FAFB"/>

  <!-- Title -->
  <text x="50" y="40" class="title">Vandelay Industries - Terraform Infrastructure</text>
  <text x="50" y="60" class="subtitle">Generated from terraform graph • {len(resources)} resources • {len(edges)} dependencies</text>
''')

    # Resource ID mapping for connections
    resource_positions = {}

    # Draw category groups
    for category in sorted_categories:
        pos = category_positions[category]
        items = pos['items']
        cat_color = CATEGORY_COLORS.get(category, '#FFFFFF')

        # Category container
        svg_parts.append(f'''
  <!-- {category} Category -->
  <g id="category-{category.lower().replace(" ", "-")}">
    <rect x="{pos['x']}" y="{pos['y']}" width="{pos['width']}" height="{pos['height']}"
          rx="12" ry="12" fill="{cat_color}" stroke="#D1D5DB" stroke-width="1" filter="url(#shadow)"/>
    <text x="{pos['x'] + 15}" y="{pos['y'] + 25}" class="category-title">{category}</text>
''')

        # Draw resources in this category
        num_cols = min(3, len(items))
        for idx, resource in enumerate(sorted(items, key=lambda r: r.resource_name)):
            col = idx % num_cols
            row = idx // num_cols

            rx = pos['x'] + category_padding + col * (box_width + box_margin)
            ry = pos['y'] + 45 + row * (box_height + box_margin)

            resource_positions[resource.full_name] = {
                'x': rx + box_width / 2,
                'y': ry + box_height / 2,
                'rx': rx,
                'ry': ry
            }

            # Determine if resource is in a cycle
            is_cycle = resource.full_name in cycle_resources
            stroke_width = "3" if is_cycle else "1"
            stroke_color = "#DC2626" if is_cycle else resource.color['stroke']
            extra_filter = ' filter="url(#cycle-glow)"' if is_cycle else ''

            # Determine text color based on fill brightness
            fill_color = resource.color['fill']
            text_class = "resource-text"
            if fill_color in ['#FFCC80', '#FFE0B3', '#C4EA97', '#F5B3BC', '#7FFFD4', '#9DD35F', '#C2A7FF', '#E8C547', '#9CA3AF', '#E5E7EB']:
                text_class = "resource-text-dark"

            # Truncate long names
            display_name = resource.resource_name
            if len(display_name) > 32:
                display_name = display_name[:30] + "..."

            svg_parts.append(f'''
    <g id="resource-{resource.full_name.replace(".", "-")}"{extra_filter}>
      <rect x="{rx}" y="{ry}" width="{box_width}" height="{box_height}"
            rx="6" ry="6" fill="{resource.color['fill']}" stroke="{stroke_color}" stroke-width="{stroke_width}"/>
      <text x="{rx + 10}" y="{ry + 14}" class="{text_class}" font-weight="bold">{resource.resource_type}</text>
      <text x="{rx + 10}" y="{ry + 28}" class="{text_class}">{display_name}</text>
    </g>''')

        svg_parts.append('\n  </g>')

    # Draw legend
    legend_x = max_width + 80
    legend_y = 80

    svg_parts.append(f'''
  <!-- Legend -->
  <g id="legend">
    <rect x="{legend_x}" y="{legend_y}" width="{legend_width}" height="{len(set(r.category for r in resources.values())) * 28 + 50}"
          rx="8" ry="8" fill="white" stroke="#E5E7EB" stroke-width="1" filter="url(#shadow)"/>
    <text x="{legend_x + 15}" y="{legend_y + 25}" class="legend-title">Resource Categories</text>
''')

    # Add legend items
    legend_categories = sorted(set(r.category for r in resources.values()))
    for idx, cat in enumerate(legend_categories):
        ly = legend_y + 45 + idx * 28
        sample_color = None
        for rt, col in RESOURCE_COLORS.items():
            if col.get('category') == cat:
                sample_color = col
                break
        if not sample_color:
            sample_color = DEFAULT_COLOR

        svg_parts.append(f'''
    <rect x="{legend_x + 15}" y="{ly}" width="20" height="20" rx="4" ry="4"
          fill="{sample_color['fill']}" stroke="{sample_color['stroke']}" stroke-width="1"/>
    <text x="{legend_x + 45}" y="{ly + 15}" class="legend-text">{cat}</text>''')

    svg_parts.append('\n  </g>')

    # Add cycle warnings if any
    if cycles:
        warning_y = legend_y + len(legend_categories) * 28 + 100
        svg_parts.append(f'''
  <!-- Cycle Warnings -->
  <g id="warnings">
    <rect x="{legend_x}" y="{warning_y}" width="{legend_width}" height="{len(cycles) * 20 + 40}"
          rx="8" ry="8" fill="#FEF2F2" stroke="#FCA5A5" stroke-width="1"/>
    <text x="{legend_x + 15}" y="{warning_y + 20}" class="cycle-warning">⚠ Dependency Cycles Detected</text>''')

        for idx, cycle in enumerate(cycles[:5]):  # Show max 5 cycles
            cy = warning_y + 40 + idx * 20
            cycle_short = " → ".join([c.split('.')[-1][:15] for c in cycle[:3]]) + "..."
            svg_parts.append(f'''
    <text x="{legend_x + 15}" y="{cy}" class="legend-text" fill="#DC2626">{cycle_short}</text>''')

        svg_parts.append('\n  </g>')

    # Close SVG
    svg_parts.append('\n</svg>')

    return ''.join(svg_parts)

def create_drawio_xml(resources: Dict[str, Resource], edges: List[Edge], cycles: List[List[str]]) -> str:
    """Generate draw.io compatible XML (can be imported to Visio)"""

    # Group resources by category
    categories = defaultdict(list)
    for resource in resources.values():
        categories[resource.category].append(resource)

    category_order = ['CDN', 'DNS', 'Certificates', 'Security', 'Networking', 'Compute',
                      'Database', 'Storage', 'IAM', 'Monitoring', 'Messaging', 'Secrets',
                      'SSM', 'Serverless', 'Utility', 'Data', 'Other']

    sorted_categories = [c for c in category_order if c in categories]
    sorted_categories += [c for c in categories if c not in sorted_categories]

    # Calculate positions
    box_width = 240
    box_height = 60
    cat_padding = 40
    cat_margin = 60

    # Resources in cycles
    cycle_resources = set()
    for cycle in cycles:
        cycle_resources.update(cycle)

    xml_parts = []
    xml_parts.append('''<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="app.diagrams.net" modified="2024-01-01T00:00:00.000Z" agent="Terraform Diagram Generator" version="22.1.0" type="device">
  <diagram id="terraform-infrastructure" name="Infrastructure">
    <mxGraphModel dx="1434" dy="780" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="2400" math="0" shadow="0">
      <root>
        <mxCell id="0"/>
        <mxCell id="1" parent="0"/>
''')

    cell_id = 2
    resource_cell_ids = {}

    current_y = 80

    # Title
    xml_parts.append(f'''        <mxCell id="{cell_id}" value="Vandelay Industries - Terraform Infrastructure" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontSize=24;fontStyle=1" vertex="1" parent="1">
          <mxGeometry x="40" y="20" width="600" height="40" as="geometry"/>
        </mxCell>
''')
    cell_id += 1

    # Draw categories and resources
    for category in sorted_categories:
        items = categories[category]
        cat_color = CATEGORY_COLORS.get(category, '#FFFFFF')

        num_cols = min(3, len(items))
        num_rows = (len(items) + num_cols - 1) // num_cols
        cat_width = cat_padding * 2 + num_cols * (box_width + 20)
        cat_height = cat_padding + 30 + num_rows * (box_height + 20)

        # Category container
        xml_parts.append(f'''        <mxCell id="{cell_id}" value="{category}" style="swimlane;whiteSpace=wrap;html=1;fillColor={cat_color};strokeColor=#999999;rounded=1;arcSize=5;fontStyle=1;fontSize=14" vertex="1" parent="1">
          <mxGeometry x="40" y="{current_y}" width="{cat_width}" height="{cat_height}" as="geometry"/>
        </mxCell>
''')
        parent_id = cell_id
        cell_id += 1

        # Resources in category
        for idx, resource in enumerate(sorted(items, key=lambda r: r.resource_name)):
            col = idx % num_cols
            row = idx // num_cols

            rx = cat_padding + col * (box_width + 20)
            ry = 30 + row * (box_height + 20)

            is_cycle = resource.full_name in cycle_resources
            stroke_color = "#DC2626" if is_cycle else resource.color['stroke']
            stroke_width = "3" if is_cycle else "1"

            display_name = resource.resource_name
            if len(display_name) > 28:
                display_name = display_name[:26] + "..."

            # Determine font color
            font_color = "#FFFFFF"
            if resource.color['fill'] in ['#FFCC80', '#FFE0B3', '#C4EA97', '#F5B3BC', '#7FFFD4', '#9DD35F', '#C2A7FF', '#E8C547', '#9CA3AF', '#E5E7EB']:
                font_color = "#1F2937"

            xml_parts.append(f'''        <mxCell id="{cell_id}" value="&lt;b&gt;{resource.resource_type}&lt;/b&gt;&lt;br&gt;{display_name}" style="rounded=1;whiteSpace=wrap;html=1;fillColor={resource.color['fill']};strokeColor={stroke_color};strokeWidth={stroke_width};fontColor={font_color};align=left;spacingLeft=8;fontSize=11" vertex="1" parent="{parent_id}">
          <mxGeometry x="{rx}" y="{ry}" width="{box_width}" height="{box_height}" as="geometry"/>
        </mxCell>
''')
            resource_cell_ids[resource.full_name] = cell_id
            cell_id += 1

        current_y += cat_height + cat_margin

    # Close XML
    xml_parts.append('''      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
''')

    return ''.join(xml_parts)

def main():
    print("Parsing Terraform graph...")
    resources, edges = parse_terraform_graph()

    if not resources:
        print("No resources found. Make sure you're in a Terraform directory.")
        return

    print(f"Found {len(resources)} resources and {len(edges)} dependencies")

    print("Detecting cycles...")
    cycles = detect_cycles(resources, edges)
    if cycles:
        print(f"⚠ Found {len(cycles)} dependency cycles")
    else:
        print("✓ No dependency cycles detected")

    print("\nGenerating SVG diagram...")
    svg_content = create_svg_diagram(resources, edges, cycles)
    svg_filename = "terraform_diagram.svg"
    with open(svg_filename, 'w') as f:
        f.write(svg_content)
    print(f"✓ Created {svg_filename}")

    print("\nGenerating draw.io XML (Visio compatible)...")
    drawio_content = create_drawio_xml(resources, edges, cycles)
    drawio_filename = "terraform_diagram.drawio"
    with open(drawio_filename, 'w') as f:
        f.write(drawio_content)
    print(f"✓ Created {drawio_filename}")

    print("\n" + "="*60)
    print("OUTPUT FILES:")
    print(f"  • {svg_filename} - Direct SVG (open in browser, import to Visio)")
    print(f"  • {drawio_filename} - draw.io format (open in draw.io, export to Visio .vsdx)")
    print("\nTo open in Visio:")
    print("  1. SVG: File → Open → select terraform_diagram.svg")
    print("  2. draw.io: Open in draw.io → File → Export → VSDX")
    print("="*60)

if __name__ == "__main__":
    main()
