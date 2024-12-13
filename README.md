# Network Graph Visualization with `NetworkView` Class

This document explains the implementation of a network graph visualization tool using the `NetworkView` class. The tool processes input data to build and visualize a directed graph while detecting potential cycles and categorizing nodes by levels.

---

## Node Class

### Overview
Represents a node in the network graph.

### Attributes
- `location`: The location associated with the node.
- `product`: The product associated with the node.
- `level`: The level of the node in the graph hierarchy (default is `0`).

### Methods
- `__repr__`: Provides a string representation of the node for debugging.
- `__eq__`: Compares two nodes for equality based on `location` and `product`.
- `__hash__`: Generates a unique hash, allowing the node to be used as a dictionary key.

---

## NetworkView Class

### Overview
The core class for building, managing, and visualizing the network graph.

### Attributes
- `push_message`: A callback function for reporting execution steps or failures.
- `adj_list`: Placeholder for an adjacency list representation of the graph.
- `graph`: Dictionary where each node maps to its level and connections.
- `connections`: Placeholder for managing edges between nodes.
- `nodes`: Placeholder for storing nodes.
- `nodes_w_levels`: Placeholder for managing nodes with their levels.
- `history`: Tracks the traversal history to detect cycles.
- `output`: Stores the graph in a format with nodes and edges for external use.

---

### Methods

#### `set_root_nodes`

**Purpose**: Identifies "root nodes" in the graph (nodes with no outgoing connections).

**Input**:
- `ip_df`: A DataFrame with columns `FromLocationId`, `FromProductId`, `ToLocationId`, and `ToProductId`.

**Process**:
1. Extracts sets of `(location, product)` tuples for "from" and "to" connections.
2. Identifies root nodes as those present in the "to" set but not in the "from" set.
3. Initializes root nodes with a level of `0` and updates `history`, `output`, and `graph`.

---

#### `iter_child_nodes`

**Purpose**: Processes child nodes recursively, connecting nodes and assigning levels.

**Input**:
- `ip_df`: Input DataFrame.
- `current_nodes`: Set of nodes being processed.
- `prev_current_nodes_df`: DataFrame of previously processed nodes.

**Process**:
1. Converts `current_nodes` into a DataFrame.
2. Compares it with `prev_current_nodes_df`. If identical, stops iteration.
3. Finds child nodes of `current_nodes` from `ip_df`.
4. For each child node:
   - Creates `Node` instances for "from" and "to".
   - Updates the `graph` with levels and edges.
   - Detects cycles by checking if a node appears in its ancestor's history.
   - Updates `output` and `history`.

---

#### `generate_graph_response`

**Purpose**: Creates a visual representation of the network using the `pyvis` library.

**Process**:
1. Initializes a `Network` object with a size and layout.
2. Adds nodes to the network with attributes like shape, color, and position based on their level.
3. Adds edges based on the `graph`.
4. Displays the graph in a browser as an HTML file.

---

#### `network_view`

**Purpose**: Main entry point for generating the network graph.

**Process**:
1. Loads data from Excel sheets (`bill_of_materials` and `transportation_sourcing`).
2. Combines sheets into a single DataFrame and standardizes columns to strings.
3. Identifies root nodes and starts processing them.
4. Iteratively processes child nodes using `iter_child_nodes`.
5. Outputs the graph structure.

---

## Features

1. **Cycle Detection**: Ensures no cycles by checking traversal history.
2. **Hierarchical Levels**: Assigns levels to nodes based on their hierarchy in the graph.
3. **Graph Visualization**: Uses `pyvis` for creating interactive and visually appealing graphs.
4. **Error Handling**: Logs errors and reports them using the `push_message` callback.

---

## Example Workflow

1. Load input data in Excel format (e.g., `bill_of_materials` and `transportation_sourcing`).
2. Call the `network_view` method with this data.
3. Process nodes and edges, detecting any cycles and assigning levels.
4. Generate and visualize the graph using `generate_graph_response`.

---

## Potential Enhancements

1. **Modularization**: Decouple the visualization logic (`generate_graph_response`) from the main processing logic for scalability.
2. **Cycle Handling**: Add specific actions (e.g., skip or log) when cycles are detected.
3. **Dynamic Input Sources**: Expand input support to include databases or APIs.

---

This explanation details the purpose and functionality of the `NetworkView` class, which processes input data to build and visualize a network graph while ensuring data integrity and detecting potential issues. Let me know if you have any questions or need further clarification!
