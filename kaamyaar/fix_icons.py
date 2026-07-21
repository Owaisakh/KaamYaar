import os
import re

replacements = {
    'LucideIcons.x': 'Icons.close',
    'LucideIcons.searchX': 'Icons.search_off',
    'LucideIcons.chevronRight': 'Icons.chevron_right',
    'LucideIcons.wrench': 'Icons.build',
    'LucideIcons.zap': 'Icons.bolt',
    'LucideIcons.snowflake': 'Icons.ac_unit',
    'LucideIcons.sparkles': 'Icons.auto_awesome',
    'LucideIcons.hammer': 'Icons.hardware',
    'LucideIcons.paintbrush': 'Icons.format_paint',
    'LucideIcons.tool': 'Icons.handyman',
    'LucideIcons.bell': 'Icons.notifications',
    'LucideIcons.search': 'Icons.search',
    'LucideIcons.alertTriangle': 'Icons.warning',
    'LucideIcons.home': 'Icons.home',
    'LucideIcons.calendar': 'Icons.calendar_today',
    'LucideIcons.user': 'Icons.person',
    'LucideIcons.camera': 'Icons.camera_alt',
    'LucideIcons.tag': 'Icons.local_offer',
    'LucideIcons.clock': 'Icons.access_time',
}

for root, _, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            path = os.path.join(root, file)
            with open(path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            new_content = content
            for old, new in replacements.items():
                new_content = new_content.replace(old, new)
            
            # Remove the lucide icons import
            new_content = re.sub(r"import 'package:lucide_icons[^']*';\n?", "", new_content)
            
            if content != new_content:
                with open(path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f'Updated {path}')
