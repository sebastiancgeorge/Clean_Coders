# Import required libraries
import pandas as pd
import numpy as np
import folium
from sklearn.cluster import KMeans

# Step 1: Generate Synthetic Dataset
def generate_synthetic_dataset(filename='synthetic_reports.csv', num_points=100):
    np.random.seed(42)
    latitude = np.random.uniform(8.0, 12.0, num_points)  # Latitude range for Kerala and Tamil Nadu
    longitude = np.random.uniform(75.0, 78.0, num_points)  # Longitude range for Kerala and Tamil Nadu
    
    data = pd.DataFrame({
        'latitude': latitude,
        'longitude': longitude
    })
    data.to_csv(filename, index=False)
    return data

# Step 2: Visualize Data on Map
def visualize_data_on_map(data, filename='map.html'):
    # Initialize map centered on South India
    m = folium.Map(location=[10.0, 76.5], zoom_start=7)

    # Add points to the map
    for _, row in data.iterrows():
        folium.CircleMarker(
            location=[row['latitude'], row['longitude']],
            radius=5, color='blue', fill=True
        ).add_to(m)

    # Save map to HTML
    m.save(filename)

# Step 3: Apply Clustering Algorithm
def apply_clustering(data, n_clusters=5, map_filename='clustered_map.html'):
    # Prepare data for clustering
    coordinates = data[['latitude', 'longitude']].to_numpy()

    # Apply K-Means clustering
    kmeans = KMeans(n_clusters=n_clusters, random_state=42)
    data['cluster'] = kmeans.fit_predict(coordinates)

    # Initialize map centered on South India
    m = folium.Map(location=[10.0, 76.5], zoom_start=7)

    # Define cluster colors
    cluster_colors = ['red', 'green', 'blue', 'purple', 'orange']

    # Add points to the map with cluster-specific colors
    for _, row in data.iterrows():
        cluster_idx = int(row['cluster'])  # Ensure cluster index is an integer
        folium.CircleMarker(
            location=[row['latitude'], row['longitude']],
            radius=5, 
            color=cluster_colors[cluster_idx % len(cluster_colors)],
            fill=True,
            fill_color=cluster_colors[cluster_idx % len(cluster_colors)]
        ).add_to(m)

    # Add cluster centroids to the map
    for cluster_idx, centroid in enumerate(kmeans.cluster_centers_):
        folium.Marker(
            location=centroid.tolist(),
            icon=folium.Icon(color=cluster_colors[cluster_idx % len(cluster_colors)], icon='info-sign'),
            popup=f"Cluster {cluster_idx + 1} - Police Jurisdiction: {get_police_jurisdiction(centroid)}"
        ).add_to(m)

    # Save updated map
    m.save(map_filename)


# Step 4: Determine Police Jurisdiction
def get_police_jurisdiction(centroid):
    # This function maps centroids to police jurisdictions (mocked for now)
    lat, lon = centroid
    if lat < 9.5:
        return "Kerala South Zone"
    elif lat < 11.0:
        return "Kerala Central Zone"
    elif lon < 77.0:
        return "Tamil Nadu West Zone"
    else:
        return "Tamil Nadu East Zone"

# Main Execution
if __name__ == '__main__':
    # Generate synthetic dataset
    dataset = generate_synthetic_dataset()

    # Visualize initial data on the map
    visualize_data_on_map(dataset, filename='map.html')

    # Apply clustering and visualize clusters
    apply_clustering(dataset, n_clusters=5, map_filename='clustered_map.html')

    print("Synthetic dataset saved as 'synthetic_reports.csv'.")
    print("Initial map saved as 'map.html'.")
    print("Clustered map saved as 'clustered_map.html'.")
